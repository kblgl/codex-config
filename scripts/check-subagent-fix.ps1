# check-subagent-fix.ps1
# 用途：检查 openai/codex 子代理消息 bug 的官方修复状态（issue #36321 / #36376 + 最新 release）
# 用法：进入脚本所在目录后执行 powershell -NoProfile -ExecutionPolicy Bypass -File ".\check-subagent-fix.ps1"
# 输出：控制台 + 追加写入脚本同目录 subagent-fix-monitor.log
# 背景：multi-agent v2 加密派工消息，DeepSeek 子代理收不到任务，详见 WORKLOG 2026-08-02 00:52

$ErrorActionPreference = 'Stop'
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$logPath = Join-Path $PSScriptRoot 'subagent-fix-monitor.log'

function Write-Log($msg) {
    $stamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $line = "$stamp  $msg"
    Write-Output $line
    Add-Content -LiteralPath $logPath -Value $line -Encoding UTF8
}

$issueUrls = @(
    'https://github.com/openai/codex/issues/36321',
    'https://github.com/openai/codex/issues/36376'
)
$allClosed = $true

foreach ($u in $issueUrls) {
    $issueNo = $u.Substring($u.LastIndexOf('/') + 1)
    try {
        $html = (Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 30).Content
        $closed = $html -match '"state"\s*:\s*"CLOSED"' -or $html -match 'aria-label="Closed issue'
        $open = $html -match '"state"\s*:\s*"OPEN"' -or $html -match 'aria-label="Open issue'
        $state = if ($closed) { 'CLOSED' } elseif ($open) { 'OPEN' } else { 'UNKNOWN' }
        if ($state -ne 'CLOSED') { $allClosed = $false }
        Write-Log "issue #$issueNo 状态: $state"
    }
    catch {
        $allClosed = $false
        Write-Log "issue #$issueNo 检查失败: $($_.Exception.Message)"
    }
}

try {
    $atom = (Invoke-WebRequest -Uri 'https://github.com/openai/codex/releases.atom' -UseBasicParsing -TimeoutSec 30).Content
    $entryMatch = [regex]::Match($atom, '<entry>([\s\S]*?)</entry>')
    if ($entryMatch.Success) {
        $entry = $entryMatch.Groups[1].Value
        $title = [regex]::Match($entry, '<title>([^<]+)</title>').Groups[1].Value
        $updated = [regex]::Match($entry, '<updated>([^<]+)</updated>').Groups[1].Value
        Write-Log "最新 release: $title（更新于 $updated）"
    }
    else {
        Write-Log '最新 release: 无法从 atom 流解析'
    }
}
catch {
    Write-Log "release 检查失败: $($_.Exception.Message)"
}

if ($allClosed) {
    Write-Log '结论: 两个 issue 均已关闭，可能已修复。先派一个最小子代理验证，再恢复常规派工。'
}
else {
    Write-Log '结论: 官方尚未修复，继续使用规避版派工（fork_turns=all + 任务文件）。'
}

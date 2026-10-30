#!/usr/bin/env bash
# Installs the AI mentor rules into the global instruction file of each AI tool,
# and runs the one-time survey that creates ~/.anti-brainrot/profile.md.
#
#   ./install.sh                      install for every detected tool (+ survey if there is no profile)
#   ./install.sh --tools claude,codex install for the listed tools only
#   ./install.sh --survey             only run the survey (create or update the profile)
#   ./install.sh --no-survey          install without the survey
#   ./install.sh --uninstall          remove the rules from every tool
#
# Tools: claude, codex, antigravity, cursor (manual paste; Cursor has no global rules file).
# Re-run after `git pull` to update: the rules are copied inline between markers.
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
MENTOR_HOME="$HOME/.anti-brainrot"
PROFILE="$MENTOR_HOME/profile.md"
RULES="$KIT_DIR/rules/mentor.md"
BEGIN="<!-- anti-brainrot:begin -->"
END="<!-- anti-brainrot:end -->"
AREAS=("Frontend" "Backend / API" "Database / SQL" "Testing" "System design" "DevOps / infra" "AI / LLM apps")

tool_file() {
  case "$1" in
    claude) echo "$HOME/.claude/CLAUDE.md" ;;
    codex) echo "${CODEX_HOME:-$HOME/.codex}/AGENTS.md" ;;
    antigravity) echo "$HOME/.gemini/GEMINI.md" ;;
  esac
}

detected_tools() {
  [ -d "$HOME/.claude" ] && echo claude
  [ -d "${CODEX_HOME:-$HOME/.codex}" ] && echo codex
  [ -d "$HOME/.gemini" ] && echo antigravity
  [ -d "$HOME/.cursor" ] || [ -d "/Applications/Cursor.app" ] && echo cursor
  return 0
}

# Prints the file without the rules block and without trailing blank lines.
strip_block() {
  awk -v b="$BEGIN" -v e="$END" '
    $0==b {skip=1; next}
    $0==e {skip=0; next}
    skip {next}
    /^[[:space:]]*$/ {blank++; next}
    {while (blank > 0) {print ""; blank--} print}
  ' "$1"
}

install_tool() {
  local tool="$1" file tmp
  if [ "$tool" = cursor ]; then
    echo "cursor: no global rules file. Paste the rules into Cursor Settings > Rules > User Rules."
    if command -v pbcopy >/dev/null; then
      pbcopy < "$RULES"
      echo "        (rules copied to clipboard)"
    else
      echo "        (copy them from $RULES)"
    fi
    return
  fi
  file="$(tool_file "$tool")"
  mkdir -p "$(dirname "$file")"
  touch "$file"
  [ -s "$file" ] && cp "$file" "$file.anti-brainrot.bak"
  tmp="$(mktemp)"
  strip_block "$file" > "$tmp"
  {
    cat "$tmp"
    [ -s "$tmp" ] && echo
    echo "$BEGIN"
    cat "$RULES"
    echo "$END"
  } > "$file"
  rm "$tmp"
  echo "$tool: installed into $file"
}

uninstall_tool() {
  local tool="$1" file tmp
  if [ "$tool" = cursor ]; then
    echo "cursor: remove the rules manually from Cursor Settings > Rules > User Rules."
    return
  fi
  file="$(tool_file "$tool")"
  [ -f "$file" ] || return 0
  tmp="$(mktemp)"
  strip_block "$file" > "$tmp"
  mv "$tmp" "$file"
  echo "$tool: removed from $file"
}

# --- survey ------------------------------------------------------------------

# Prints the data rows of the table under "## <name>" in a profile (header and separator skipped).
table_rows() {
  [ -f "$1" ] || return 0
  awk -v s="## $2" '
    $0==s {on=1; next}
    /^## / {on=0}
    on && /^\| / && !/^\|---/ {if (seen++) print}
  ' "$1"
}

# t <english> <vietnamese>: prints the prompt in the chosen language.
t() { if [ "$UI" = vi ]; then printf '%s\n' "$2"; else printf '%s\n' "$1"; fi; }

ask() {
  read -r -p "> " ANSWER || { echo; echo "Input ended, survey aborted." >&2; exit 1; }
}

ask_level() {
  while true; do
    ask
    case "$ANSWER" in [1-4]) return ;; esac
    t "Please enter 1, 2, 3 or 4." "Nhập 1, 2, 3 hoặc 4."
  done
}

run_survey() {
  local today old_skills old_stacks old_concepts old_history created
  today="$(date +%F)"
  mkdir -p "$MENTOR_HOME"
  old_skills="$(table_rows "$PROFILE" Skills)"
  old_stacks="$(table_rows "$PROFILE" "Known stacks")"
  old_concepts="$(table_rows "$PROFILE" "Concepts passed")"
  old_history="$(table_rows "$PROFILE" History)"
  created="$(grep -m1 '^- \*\*Created:\*\*' "$PROFILE" 2>/dev/null | sed 's/.*:\*\* //' || true)"
  [ -n "$created" ] || created="$today"

  echo
  echo "anti-brainrot survey (~5 min). Language / Ngôn ngữ: 1) English  2) Tiếng Việt"
  ask
  if [ "$ANSWER" = 2 ]; then UI=vi; lang="Tiếng Việt"; else UI=en; lang="English"; fi

  t "Your role and years of experience?" "Vai trò hiện tại và số năm kinh nghiệm?"
  ask; local role="$ANSWER"
  t "Your main goal right now?" "Mục tiêu chính của bạn lúc này?"
  ask; local goal="$ANSWER"

  t "Rate each area by what you can DO:" "Chấm từng mảng theo việc bạn LÀM ĐƯỢC:"
  t "  1 never written it myself · 2 only with an example or AI · 3 write and debug it alone · 4 can teach it" \
    "  1 chưa từng tự viết · 2 chỉ viết được khi có ví dụ hoặc AI · 3 tự viết và debug được · 4 dạy lại được"
  local levels=() area
  for area in "${AREAS[@]}"; do
    echo "- $area"
    ask_level
    levels+=("$ANSWER")
  done

  t "Other areas you want to be strict about, comma-separated (Enter to skip):" \
    "Mảng khác muốn bị siết, cách nhau bằng dấu phẩy (Enter để bỏ qua):"
  ask; local extra_strict="$ANSWER"

  t "Stacks you use and your level, e.g. 'React=4, Go=1' (Enter to skip):" \
    "Các stack bạn dùng và mức của bạn, ví dụ 'React=4, Go=1' (Enter để bỏ qua):"
  ask; local stacks_in="$ANSWER"

  t "Signs you have noticed (numbers, comma-separated):" "Dấu hiệu bạn đã gặp (nhập số, cách nhau bằng dấu phẩy):"
  t "  1 can't debug without AI  2 can't explain code I just committed  3 forget basic syntax  4 too lazy to design the solution/flow  5 avoid docs" \
    "  1 không debug được khi không có AI  2 không giải thích được code vừa commit  3 quên syntax cơ bản  4 lười tự nghĩ solution/flow  5 ngại đọc docs"
  ask; local signs_in="$ANSWER"

  t "How strict should the AI be? 1) gentle  2) direct  3) strict" "AI nên gắt mức nào? 1) nhẹ nhàng  2) thẳng thắn  3) khắt khe"
  ask
  local strictness=direct
  case "$ANSWER" in 1) strictness=gentle ;; 3) strictness=strict ;; esac

  local sign_names=("" "Can't debug without AI" "Can't explain code just committed" "Forgets basic syntax" "Too lazy to design the solution/flow" "Avoids documentation")
  local tmp i level old checked strict s name
  tmp="$(mktemp)"
  {
    echo "# anti-brainrot profile"
    echo
    echo "<!-- Written by \`install.sh --survey\`, then kept up to date by the AI. Personal: never commit this file. -->"
    echo
    echo "- **Created:** $created"
    echo "- **Last survey:** $today"
    echo "- **Reply language:** $lang"
    echo "- **Strictness:** $strictness"
    echo "- **Context:** $role; goal: $goal"
    echo
    echo "## Skills"
    echo
    echo "| Area | Level (1–4) | Checked | Strict |"
    echo "|---|---|---|---|"
    for i in "${!AREAS[@]}"; do
      area="${AREAS[$i]}"; level="${levels[$i]}"
      checked="—"; [ "$level" -ge 3 ] && checked="no"
      # Keep "yes" when the area was already checked at the same level.
      old="$(echo "$old_skills" | awk -F'|' -v a="$area" '{for (j=2; j<=4; j++) gsub(/^ +| +$/, "", $j)} $2==a {print $3 "/" $4}')"
      [ "$old" = "$level/yes" ] && checked="yes"
      strict="no"; [ "$level" -le 2 ] && strict="yes"
      echo "| $area | $level | $checked | $strict |"
    done
    IFS=',' read -r -a extras <<< "$extra_strict"
    for s in "${extras[@]+"${extras[@]}"}"; do
      name="$(echo "$s" | xargs)"; [ -n "$name" ] && echo "| $name | — | — | yes |"
    done
    echo
    echo "## Known stacks"
    echo
    echo "| Stack | Level (1–4) |"
    echo "|---|---|"
    IFS=',' read -r -a new_stacks <<< "$stacks_in"
    local new_names="|"
    for s in "${new_stacks[@]+"${new_stacks[@]}"}"; do
      name="$(echo "${s%%=*}" | xargs)"; level="$(echo "${s#*=}" | xargs)"
      [ -n "$name" ] || continue
      new_names="$new_names$name|"
      echo "| $name | $level |"
    done
    # Keep stacks from the previous profile that were not re-rated.
    while IFS= read -r row; do
      [ -n "$row" ] || continue
      name="$(echo "$row" | awk -F'|' '{print $2}' | xargs)"
      case "$new_names" in *"|$name|"*) ;; *) echo "$row" ;; esac
    done <<< "$old_stacks"
    echo
    echo "## Concepts passed"
    echo
    echo "| Concept | Area | Date |"
    echo "|---|---|---|"
    [ -z "$old_concepts" ] || echo "$old_concepts"
    echo
    echo "## Signs to counter"
    echo
    IFS=',' read -r -a signs <<< "$signs_in"
    for s in "${signs[@]+"${signs[@]}"}"; do
      s="$(echo "$s" | xargs)"
      case "$s" in [1-5]) echo "- ${sign_names[$s]}" ;; esac
    done
    echo
    echo "## History"
    echo
    echo "| Date | Area | Level before | Level after |"
    echo "|---|---|---|---|"
    [ -z "$old_history" ] || echo "$old_history"
    for i in "${!AREAS[@]}"; do
      area="${AREAS[$i]}"
      old="$(echo "$old_skills" | awk -F'|' -v a="$area" '{gsub(/^ +| +$/, "", $2); gsub(/^ +| +$/, "", $3)} $2==a {print $3}')"
      if [ -n "$old" ] && [ "$old" != "${levels[$i]}" ]; then
        echo "| $today | $area | $old | ${levels[$i]} |"
      fi
    done
  } > "$tmp"
  mv "$tmp" "$PROFILE"
  echo
  t "Profile written to $PROFILE. Your AI tool will check areas you rated 3–4 in the next session." \
    "Đã ghi profile vào $PROFILE. Ở session tới, AI sẽ hỏi kiểm tra các mảng bạn chấm 3–4."
}

# --- main --------------------------------------------------------------------

mode=install
survey=auto
tools=""
while [ $# -gt 0 ]; do
  case "$1" in
    --uninstall) mode=uninstall ;;
    --survey) mode=survey ;;
    --no-survey) survey=no ;;
    --tools) tools="$(echo "$2" | tr ',' ' ')"; shift ;;
    -h|--help) sed -n '2,13p' "$0"; exit 0 ;;
    *) echo "unknown option: $1" >&2; exit 1 ;;
  esac
  shift
done

if [ "$mode" = survey ]; then
  run_survey
  exit 0
fi

[ -n "$tools" ] || tools="$(detected_tools)"
if [ -z "$tools" ]; then
  echo "No supported AI tool detected. Use --tools to choose." >&2
  exit 1
fi

if [ "$mode" = install ]; then
  mkdir -p "$MENTOR_HOME/templates"
  cp "$KIT_DIR"/templates/*.md "$MENTOR_HOME/templates/"
  echo "templates: copied to $MENTOR_HOME/templates"
fi

for tool in $tools; do
  case "$tool" in
    claude|codex|antigravity|cursor) "${mode}_tool" "$tool" ;;
    *) echo "unknown tool: $tool" >&2 ;;
  esac
done

if [ "$mode" = install ]; then
  if [ ! -f "$PROFILE" ] && [ "$survey" = auto ]; then
    if [ -t 0 ]; then
      run_survey
    else
      echo "No profile yet. Run ./install.sh --survey in a terminal."
    fi
  fi
  echo
  echo "Done. Open a git repository with your AI tool to start."
else
  echo
  echo "Your profile in $MENTOR_HOME was kept. Delete that folder to remove it."
fi

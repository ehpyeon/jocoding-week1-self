#!/bin/bash
# 자동 테스트, 커밋, 배포 스크립트

set -e

PROJECT_DIR="/Users/ehp/projects/jocoding-week1-self"
cd "$PROJECT_DIR"

echo "🚀 자동 배포 시작..."

# 1. 테스트 실행
echo "📝 Step 1: 테스트 실행"
bash scripts/test.sh

# 2. 변경사항 확인
if git diff --quiet && git diff --cached --quiet; then
    echo "ℹ️  변경사항이 없습니다"
    exit 0
fi

# 3. 변경된 파일 목록
echo "📝 Step 2: 변경된 파일들"
git status --short

# 4. 스테이징
echo "📝 Step 3: 스테이징"
git add .

# 5. 커밋 (변경사항 요약 자동 생성)
CHANGED_FILES=$(git diff --cached --name-only | tr '\n' ', ' | sed 's/,$//')
COMMIT_MSG="Update: ${CHANGED_FILES}

Auto-deployed via Claude Code hook

Co-Authored-By: Claude Opus 4.5 <noreply@anthropic.com>"

echo "📝 Step 4: 커밋"
git commit -m "$COMMIT_MSG"

# 6. 푸시
echo "📝 Step 5: GitHub 푸시"
git push origin main

# 7. Cloudflare Pages 배포
echo "📝 Step 6: Cloudflare Pages 배포"
wrangler pages deploy . --project-name jocoding-week1-self --branch main --commit-dirty=true

echo "✅ 배포 완료!"
echo "🌐 https://jocoding-week1-self.pages.dev"

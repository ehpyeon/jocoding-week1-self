#!/bin/bash
# HTML 유효성 검사 스크립트

set -e

echo "🔍 HTML 파일 검사 중..."

# index.html 존재 확인
if [ ! -f "index.html" ]; then
    echo "❌ index.html 파일이 없습니다"
    exit 1
fi

# 기본 HTML 구조 검사
if ! grep -q "<!DOCTYPE html>" index.html; then
    echo "❌ DOCTYPE 선언이 없습니다"
    exit 1
fi

if ! grep -q "<html" index.html; then
    echo "❌ html 태그가 없습니다"
    exit 1
fi

if ! grep -q "<head>" index.html; then
    echo "❌ head 태그가 없습니다"
    exit 1
fi

if ! grep -q "<body>" index.html; then
    echo "❌ body 태그가 없습니다"
    exit 1
fi

if ! grep -q "</html>" index.html; then
    echo "❌ html 닫기 태그가 없습니다"
    exit 1
fi

# 필수 메타 태그 검사
if ! grep -q 'charset="UTF-8"' index.html; then
    echo "⚠️  charset 메타 태그 권장"
fi

if ! grep -q 'viewport' index.html; then
    echo "⚠️  viewport 메타 태그 권장"
fi

echo "✅ HTML 검사 통과!"
exit 0

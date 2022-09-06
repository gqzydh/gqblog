#!/usr/bin/env sh

# 确保脚本抛出遇到的错误
set -e

# 生成静态文件
npm run build

# 进入生成的文件夹
cd docs/.vuepress/dist

# deploy to github
#echo 'b.gqzydh.github.io' > CNAME
if [ -z "$VDOING" ]; then
  msg='deploy'
  githubUrl=git@github.com:gqzydh/gqzydh.github.io.git
else
  msg='来自 github actions的自动部署'
  githubUrl=https://gqzydh:${VDOING}@github.com/gqzydh/gqzydh.github.io.git
  git config --global user.name "gqzydh"
  git config --global user.email "gqzydh@163.com"
fi
git init
git add -A
git commit -m "${msg}"
git push -f $githubUrl main:gh-pages # 推送到github
#git push -f git@github.com:gqzydh/gqblog.git main:gh-pages


# deploy to coding
#echo 'www.miluluu.com\miluluu.com' > CNAME  # 自定义域名
#if [ -z "$CODING_TOKEN" ]; then  # -z 字符串 长度为0则为true；$CODING_TOKEN来自于github仓库`Settings/Secrets`设置的私密环境变量
#  codingUrl=git@e.coding.net:miluluu/miluluu.git
#else
#  codingUrl=https://miluluu:${CODING_TOKEN}@e.coding.net/miluluu/miluluu/miluluu.git
#fi
#git add -A
#git commit -m "${msg}"
#git push -f $codingUrl main # 推送到coding

cd - # 退回开始所在目录
rm -rf docs/.vuepress/dist
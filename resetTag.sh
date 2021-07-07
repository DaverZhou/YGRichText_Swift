#!/bin/sh

echo "================================"
echo "---------【 开始重置 】---------"
echo "================================"

# 获取最后一次tag版本
lastVersion=$(git describe --tags `git rev-list --tags --max-count=1`)

# 删除最后一个版本tag
git tag -d $lastVersion
git push origin :$lastVersion
echo "---------删除版本【 $lastVersion 】---------"
# 更新代码
git add -A && git commit -m $lastVersion
git push
echo "---------更新完成【 $lastVersion 】---------"

# 打上tag
git tag $lastVersion
git push --tags
git push

echo "================================"
echo "---------重置最后一次版本【 $lastVersion 】---------"
echo "================================"


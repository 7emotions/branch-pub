
# branch-pub

[![Release](https://img.shields.io/github/v/release/7emotions/branch-pub?style=flat-square)](https://github.com/7emotions/branch-pub/releases)
[![License](https://img.shields.io/github/license/7emotions/branch-pub?style=flat-square)](https://github.com/7emotions/branch-pub/blob/main/LICENSE)
[![Open Issues](https://img.shields.io/github/issues-raw/7emotions/branch-pub?style=flat-square)](https://github.com/7emotions/branch-pub/issues)

一个强大的 GitHub Actions，用于将编译产物发布到任意 Git 托管服务的新分支，轻松部署 Pages。

## 简介

`branch-pub` Action 旨在简化静态网站、Node.js 应用、MkDocs 等应用的 Pages 部署流程。它允许开发者将编译后的产物自动发布到 Git 托管服务的新分支，实现快速部署。

## 特性

* **跨平台支持：** 适用于任意 Git 托管服务。
* **灵活配置：** 支持自定义分支名称、发布目录等。
* **自动化部署：** 自动处理编译产物，无需手动操作。
* **广泛适用：** 适用于静态网站、Node.js 应用、MkDocs 等多种应用。

## 使用场景

* 静态网站部署（例如，使用 Hugo、Jekyll 构建的网站）。
* Node.js 应用部署（例如，使用 Vue、React 构建的应用）。
* MkDocs 文档部署。
* 任意需要将编译产物发布到 Git Pages 的场景。

## 使用方法

### 前置条件

* 一个 Git 托管服务账号（例如，AtomGit、GitHub、GitLab）。
* 一个个人访问令牌 (PAT)，具有仓库写入权限。
* 一个 GitHub 仓库，用于托管你的项目。

### 工作流示例

```yaml
name: Deploy Pages

on:
  push:
    branches:
      - main # 触发部署的分支

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Build project
        run: |
          npm install
          npm run build # 替换为你的构建命令

      - name: Deploy to Pages
        uses: 7emotions/branch-pub@v4
        with:
          token: ${{ secrets.GIT_TOKEN }} # 替换为你的 PAT Secret 名称
          user: your_username # 替换为你的 Git 用户名
          repo: your_repo/your_project # 替换为你的仓库路径
          github_domain: your_git_domain # 替换为你的Git 域名，如果是github可以省略此行
          branch: pages # 部署到的分支名称
          folder: dist # 编译产物目录
```

### 参数说明

* `token`: **(必填)** 你的 Git 托管服务个人访问令牌 (PAT)。
* `user`: **(必填)** 你的 Git 托管服务用户名。
* `repo`: **(必填)** 你的仓库路径。
* `github_domain`: **(可选)** 你的 Git 托管服务域名，默认为 `github.com`。
* `branch`: **(必填)** 要部署到的分支名称。
* `folder`: **(必填)** 要部署的文件夹路径。

## 贡献

欢迎提交 issue 和 pull request，共同完善 `branch-pub` Action。

## 许可证

[MIT](./LICSENCE)

## 联系

[mail](mailto://lorenzo.feng@njust.edu.cn)


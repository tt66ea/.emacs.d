# Emacs 30.2 配置原生化改造清单

## 一、code.el — 核心替换

### 1. flycheck → flymake（内置）
- [ ] 移除 `use-package flycheck` 块（第 25-39 行）
- [ ] 添加 `(add-hook 'prog-mode-hook #'flymake-mode)`
- [ ] 可选：利用 Emacs 30 新选项 `flymake-indicator-type`、`flymake-show-diagnostics-at-end-of-line`

### 2. lsp-mode → eglot（内置）
- [ ] 移除 `use-package lsp-mode` 块（第 57-71 行）
- [ ] 添加 eglot 配置：
  ```elisp
  (use-package eglot
    :hook ((c-ts-mode c++-ts-mode) . eglot-ensure)
    :config
    (setq eglot-autoshutdown t))
  ```
- [ ] 移除 `(lsp-mode . lsp-enable-which-key-integration)` hook

### 3. company → corfu（GNU ELPA，半官方）
- [ ] 移除 `use-package company` 块（第 45-55 行）
- [ ] 添加 corfu：
  ```elisp
  (use-package corfu
    :ensure t
    :init (global-corfu-mode)
    :custom
    (corfu-auto t)
    (corfu-auto-prefix 1)
    (corfu-auto-delay 0)
    (corfu-preselect 'prompt)
    (corfu-cycle t))
  ```

### 4. which-key 直接启用（Emacs 30 已内置）
- [ ] 添加 `(which-key-mode 1)`

### 5. treesit-auto — 保留
- [x] 不修改（Windows 兼容性需要）

---

## 二、key.el — 移除 company 键位

- [ ] 移除 tab/backtab 的 company 绑定（第 12-16 行）
  ```elisp
  ;; 删除以下：
  (with-eval-after-load 'cc-mode
    (define-key c-mode-map [tab] #'company-complete)
    (define-key c++-mode-map [tab] #'company-complete)
    (define-key c++-mode-map [backtab] #'indent-for-tab-command))
  ```
- [ ] 移除 `C-.` 绑定（第 20 行）：
  ```elisp
  ;; 删除：
  (global-set-key (kbd "C-.") 'company-complete-common)
  ```

---

## 三、搜索增强（新增）

- [ ] 在 `base.el` 或新建文件添加：
  ```elisp
  (setq grep-use-headings t)                    ; grep 按文件分组
  (setq imenu-flatten t)                         ; imenu 扁平化
  (global-set-key (kbd "C-c p s") 'project-find-regexp)  ; 项目正则搜索
  (global-set-key (kbd "C-c p r") 'rgrep)                 ; 递归 grep
  ```

---

## 四、可选增强（Emacs 30 新功能）

- [ ] 考虑启用 `global-visual-wrap-prefix-mode`（长行折行保持缩进视觉）
- [ ] 考虑启用 `kill-ring-deindent-mode`（复制代码自动去缩进）

---

## 五、清理死代码（当前未被 init.el 加载的文件）

- [ ] 删除 `setting/auto-save.el`（Emacs 26 起有内置 `auto-save-visited-mode`）
- [ ] 删除 `setting/google.el`（最后两行 `add-hook` 无实际效果）
- [ ] 删除 `setting/multi-gdb-ui.el`（Emacs 24+ 内置 gdb-mi.el 已覆盖）
- [ ] 删除 `setting/multi-gud.el`（同上）
- [ ] 删除 `setting/org-preview.el`（内置 `org-latex-preview` 已取代）

---

## 六、保留不动的文件

| 文件 | 原因 |
|------|------|
| `base.el` | 大部分为内置功能，仅需添加搜索配置 |
| `file.el` | 纯内置 `fido-vertical-mode` |
| `my-evil.el` | evil 无内置替代 |
| `modeline.el` | 用户要求不动 |
| `org-mode-setting.el` | 当前未加载，用户视需要启用 |

---

## 七、保留的外部包（7 个）

`evil` `evil-leader` `spacemacs-theme` `yasnippet` `rainbow-delimiters` `neotree` `window-numbering`

---

## 八、init.el 小修改

- [ ] 视需要取消注释 `(load "org-mode-setting.el")`
- [ ] `custom-set-variables` 中手动清理 lsp/flycheck/company 相关变量（首次启动后 describe 确认）

;;; package --- tt66ea
;;; Commentary:
;;; Code:

(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1))

(defun mycompile()
  "Compile a cpp-file."
  (interactive)
  (save-buffer)
  (compile (format "g++ %S -o %S" (buffer-file-name) (concat (substring buffer-file-name 0 -4) ".exe")))
  );;clang++ -target x86_64-pc-windows-gnu name.cpp -o name.exe

(defun mycompile-gdb()
  "Compile a cpp-file for debug."
  (interactive)
  (save-buffer)
  (compile (format "g++ %S -g -o %S" (buffer-file-name) (concat (substring buffer-file-name 0 -4) ".exe")))
  );;clang++ -target x86_64-pc-windows-gnu name.cpp -o name.exe

;; == flymake == (built-in, Emacs 30)
(add-hook 'prog-mode-hook #'flymake-mode)
(with-eval-after-load 'flymake
  (setq flymake-indicator-type 'margins)
  (setq flymake-show-diagnostics-at-end-of-line t)
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flymake diagnostics" eos)
                 (display-buffer-reuse-window
                  display-buffer-in-side-window)
                 (side            . bottom)
                 (reusable-frames . visible)
                 (window-height   . 0.33))))

;; == corfu == (GNU ELPA, CAPF-based)
(use-package corfu
  :ensure t
  :init (global-corfu-mode)
  :custom
  (corfu-auto t)              ; 自动弹出补全菜单
  (corfu-auto-prefix 1)       ; 敲 1 个字符即触发
  (corfu-auto-delay 0)        ; 无延迟
  (corfu-preselect 'prompt)
  (corfu-cycle t))            ; 可循环选择

;; == which-key == (Emacs 30 built-in)
(which-key-mode 1)

;; == eglot == (built-in LSP client)
(use-package eglot
  :hook ((c-ts-mode c++-ts-mode) . eglot-ensure)
  :config
  (setq eglot-autoshutdown t)
  (setq eglot-events-buffer-size 0)
  ;; On Windows, ensure clangd is in PATH (e.g. via MinGW64 or LLVM):
  ;;   (add-to-list 'eglot-server-programs
  ;;                '((c-ts-mode c++-ts-mode) . ("clangd")))
  )

;; == cape == (GNU ELPA, Capf utilities)
(use-package cape
  :ensure t)

;; == yasnippet-capf == (GitHub, yasnippet -> CAPF bridge)
(use-package yasnippet-capf
  :vc (:url "https://github.com/elken/yasnippet-capf" :rev :newest)
  :after yasnippet
  :custom
  (yasnippet-capf-lookup-by 'key)
  :config
  ;; prog-mode (non-eglot): 仅 yasnippet
  (add-hook 'prog-mode-hook
            (lambda ()
              (setq-local completion-at-point-functions
                          (list #'yasnippet-capf))))
  ;; eglot 激活后: yasnippet 优先 + nonexclusive eglot
  (defun my/eglot-capf-nonexclusive ()
    "EGLOT Capf without exclusivity."
    (cape-wrap-nonexclusive #'eglot-completion-at-point))
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (setq-local completion-at-point-functions
                          (list #'yasnippet-capf
                                #'my/eglot-capf-nonexclusive)))))


(defun my-c-style-setup ()
  "Setup c/c++ style."
  (c-set-style "stroustrup")
  (setq c-basic-offset 4)
  (c-set-offset 'innamespace 0) ;;namespace内不缩进
  (local-set-key (kbd "RET") 'newline-and-indent)
)
;; (add-hook 'c-mode-common-hook #'my-c-style-setup)
;; (setq c-default-style "awk");;;设置C语言风格
(setq-default indent-tabs-mode nil)  ;;将tab转变为空格
;; (setq c-basic-offset 4)
(setq-default tab-width 4) ;;tab width 设置缩进以及tab键
;; (c-set-offset 'innamespace 0) ;;namespace内不缩进

;; ========================================================
;; 现代 C/C++ 配置 (Tree-sitter)
;; ========================================================

;; 自动下载和管理 Tree-sitter 语法库 (Windows 兼容)
(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-install 'prompt)
  :config
  (global-treesit-auto-mode)
  ;; Emacs 30 内置 major-mode-remap-alist，改用原生方式 remap
  ;; 避免和 treesit-auto-add-to-auto-mode-alist 'all 冲突
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode)))


;; 2. Tree-sitter C/C++ 模式配置
(use-package c-ts-mode
  :config
  ;; 设置缩进风格。'linux 风格配合 4 空格偏移，在视觉上最接近 VS Code 默认的 C++ 体验
  (setq c-ts-mode-indent-style 'linux)
  (setq c-ts-mode-indent-offset 4))


(use-package rainbow-delimiters
  :ensure t
  :hook (lisp-mode . rainbow-delimiters-mode))
;;(require 'rainbow-delimiters)
;;(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(provide 'code)
;;; code.el ends here

;;; package --- tt66ea
;;; Commentary:
;;; Code:

;;(global-company-mode 1)

(use-package yasnippet
  :ensure t
  :init (yas-global-mode 1))

(defun mycompile()
  "Compile a cpp-file."
  (interactive)
  (save-buffer)
  (compile (format "g++ %S -o %S" (buffer-file-name) (concat (substring buffer-file-name 0 -4))))
  );;clang++ -target x86_64-pc-windows-gnu name.cpp -o name.exe

(defun mycompile-gdb()
  "Compile a cpp-file for debug."
  (interactive)
  (save-buffer)
  (compile (format "g++ %S -g -o %S" (buffer-file-name) (concat (substring buffer-file-name 0 -4))))
  );;clang++ -target x86_64-pc-windows-gnu name.cpp -o name.exe

(use-package flycheck
  :ensure t
  ;; :init (global-flycheck-mode)
  :hook (prog-mode . flycheck-mode)
  :config
  (setq flycheck-checker-error-threshold 100)
  (setq-default flycheck-disabled-checkers '(c/c++-clang))
  (add-to-list 'display-buffer-alist
               `(,(rx bos "*Flycheck errors*" eos)
                 (display-buffer-reuse-window
                  display-buffer-in-side-window)
                 (side            . bottom)
                 (reusable-frames . visible)
                 (window-height   . 0.33)))
  )
;;(add-hook 'after-init-hook #'global-flycheck-mode)

;; == company ==
;; (require 'cc-mode)
;; (require 'company)
(use-package company
  :ensure t
  ;; :init (global-company-mode)
  :hook (prog-mode . company-mode)
  :config
  (setq company-minimum-prefix-length 1) ; 只需敲 1 个字母就开始进行自动补全
  (setq company-tooltip-align-annotations t)
  (setq company-idle-delay 0.0)
  (setq company-show-numbers t) ;; 给选项编号 (按快捷键 M-1、M-2 等等来进行选择).
  (setq company-selection-wrap-around t)
  (setq company-transformers '(company-sort-by-occurrence))) ; 根据选择的频率进行排序，读者如果不喜欢可以去掉

(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l"
	lsp-file-watch-threshold 500)
  :hook 
  (lsp-mode . lsp-enable-which-key-integration) ; which-key integration
  :commands (lsp lsp-deferred)
  :config
  (setq lsp-completion-provider :none) ;; 阻止 lsp 重新设置 company-backend 而覆盖我们 yasnippet 的设置
  (setq lsp-headerline-breadcrumb-enable t)
  )


(defun my-c-style-setup ()
  "Setup c/c++ style."
  (c-set-style "awk")
  (setq c-basic-offset 4)
  (c-set-offset 'innamespace 0) ;;namespace内不缩进
)
(add-hook 'c-mode-common-hook #'my-c-style-setup)
;; (setq c-default-style "awk");;;设置C语言风格
(setq-default indent-tabs-mode nil)  ;;将tab转变为空格
;; (setq c-basic-offset 4)
(setq-default tab-width 4) ;;tab width 设置缩进以及tab键
;; (c-set-offset 'innamespace 0) ;;namespace内不缩进


(use-package c++-mode
  :hook
  (c-mode . lsp-deferred)
  (c++-mode . lsp-deferred)
  )

(use-package rainbow-delimiters
  :ensure t
  :hook (lisp-mode . rainbow-delimiters-mode))
;;(require 'rainbow-delimiters)
;;(add-hook 'lisp-mode-hook 'rainbow-delimiters-mode)
(provide 'code)
;;; code.el ends here

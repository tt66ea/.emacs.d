;;; package --- tt66ea-base
;;; Commentary:
;;; Code:

(global-display-line-numbers-mode t)

;;(setq-default indent-tabs-mode nil)  ;;将tab转变为空格
;;(setq c-basic-offset 4)
;;(setq default-tab-width 4) ;;tab width 设置缩进以及tab键
;;(c-set-offset 'innamespace 0) ;;namespace内不缩进

(setq ring-bell-function 'ignore)

(set-frame-font "Hack-16")

(electric-pair-mode t)
(electric-layout-mode t)
(electric-indent-mode t)
;;electric pair 括号补全

(setq-default cursor-type 'bar)

(use-package evil
  :init
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor 'bar)
  )
(show-paren-mode t) ;;show paren 括号配对

(global-hl-line-mode t) ;;high light line 高亮当前行
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    (font-spec :family "Microsoft Yahei" :size 18)))

;; (require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
             '("Org" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
             )
;; (package-initialize)

(use-package spacemacs-theme
  :init (load-theme 'spacemacs-dark t))

;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-hook'c++-mode-common-hook(lambda()))
(delete-selection-mode)

;; 关闭备份文件、自动保存文件和欢迎界面，设置滚动边距和滚动行为
(setq make-backup-files nil)
(setq inhibit-splash-screen t)
(setq auto-save-default nil)
(setq scroll-margin 3  scroll-conservatively 10000)

(display-time-mode 1) ;; 常显
(setq display-time-24hr-format t) ;;格式
(setq display-time-day-and-date t) ;;显示时间、星期、日期

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(use-package neotree
  :init 
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 20)
  )

(global-auto-revert-mode 1)

(fset 'yes-or-no-p 'y-or-n-p)

(setq default-directory "~/Documents/note/tt66ea/")

(window-numbering-mode 1)
;;设置默认读入文件编码
;;(prefer-coding-system 'utf-8)
;;设置写入文件编码
;;(setq default-buffer-file-coding-system 'utf-8)

;;设置自动输入法切换

;; (use-package sis
;;   :config
;;   (sis-ism-lazyman-config "1" "2" 'fcitx5)
;;   ;; 启用 /光标颜色/ 模式
;;   (sis-global-cursor-color-mode t)
;;   ;; 启用 /respect/ 模式
;;   (sis-global-respect-mode t)
;;   ;; 为所有缓冲区启用 /context/ 模式
;;   ;;(sis-global-context-mode t)
;;   ;; 为所有缓冲区启用 /inline english/ 模式
;;   (sis-global-inline-mode t)
;;   (setq sis-inline-tighten-head-rule 'zero)
;;   (setq sis-inline-tighten-tail-rule 'zero)
;;   (setq sis-other-cursor-color "#6677CC")
;;   (add-to-list 'sis-respect-minibubffer-triggers
;;                ())
;;   )

(provide 'base)
;;; base.el ends here

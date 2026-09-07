;;; package --- tt66ea-base
;;; Commentary:
;;; Code:

(global-display-line-numbers-mode t)

;;(setq-default indent-tabs-mode nil)  ;;将tab转变为空格
;;(setq c-basic-offset 4)
;;(setq default-tab-width 4) ;;tab width 设置缩进以及tab键
;;(c-set-offset 'innamespace 0) ;;namespace内不缩进

(setq ring-bell-function 'ignore)

;; ====================================================================
;; 字体配置 (GUI 环境生效，兼顾终端/守护进程与多 Frame)
;; ====================================================================

(defun my/setup-fonts (&optional frame)
  "Setup fonts for Emacs GUI frame."
  (when (display-graphic-p frame)
    (let* ((f (or frame (selected-frame)))
           (en-font "Hack-16")
           ;; 优先使用已安装的霞鹜文楷等宽，若无则使用微软雅黑
           (zh-font (cond
                     ((find-font (font-spec :family "LXGW WenKai Mono")) "LXGW WenKai Mono")
                     ((find-font (font-spec :family "霞鹜文楷等宽"))     "霞鹜文楷等宽")
                     ((find-font (font-spec :family "Microsoft YaHei"))  "Microsoft YaHei")
                     (t "Microsoft Yahei"))))
      ;; 1. 设置默认英文字体（同时应用到当前 Frame 与未来所有新建 Frame）
      (set-frame-font en-font nil (list f))
      (add-to-list 'default-frame-alist `(font . ,en-font))

      ;; 2. 设置中文字体（nil 表示针对 frame f 的 active fontset；t 表示针对全局 default fontset）
      ;; 不写死 :size，让 Emacs 自动按 Hack-16 的字形度量按比例联动缩放
      (dolist (charset '(kana han bopomofo cjk-misc))
        (set-fontset-font nil charset (font-spec :family zh-font) f)
        (set-fontset-font t   charset (font-spec :family zh-font)))

      ;; 3. 符号字符集（Segoe UI Symbol 保障原生符号，排除中文全角劫持）
      (set-fontset-font nil 'symbol (font-spec :family "Segoe UI Symbol") f)
      (set-fontset-font t   'symbol (font-spec :family "Segoe UI Symbol")))))

;; 启动时对当前 GUI 窗口立即生效
(when (display-graphic-p)
  (my/setup-fonts))

;; 新建 GUI 窗口时自动应用
(add-hook 'after-make-frame-functions #'my/setup-fonts)

;; --------------------------------------------------------------------
;; 【备用配置：方案 A（经典 Hack + 微软雅黑 去毒修复版）】
;; 若需完全切回传统方案 A，取消下面注释并注释掉上方 (my/setup-fonts) 即可：
;; --------------------------------------------------------------------
;; (when (display-graphic-p)
;;   (set-frame-font "Hack-16" nil t)
;;   (add-to-list 'default-frame-alist '(font . "Hack-16"))
;;   (dolist (charset '(kana han bopomofo cjk-misc))
;;     (set-fontset-font "fontset-default" charset
;;                       (font-spec :family "Microsoft Yahei" :size 16)))
;;   (set-fontset-font "fontset-default" 'symbol
;;                     (font-spec :family "Segoe UI Symbol")))
;; --------------------------------------------------------------------
;; 【备用配置：方案 B2（全盘纯正霞鹜文楷等宽 LXGW 单字体一体化）】
;; (when (display-graphic-p)
;;   (set-frame-font "LXGW WenKai Mono-16" nil t)
;;   (add-to-list 'default-frame-alist '(font . "LXGW WenKai Mono-16")))
;; --------------------------------------------------------------------


(electric-pair-mode t)
;;(electric-layout-mode t)
(electric-indent-mode t)
;;electric pair 括号补全

(setq-default cursor-type 'bar)


(show-paren-mode t) ;;show paren 括号配对

(global-hl-line-mode t) ;;high light line 高亮当前行

(require 'package)
(setq package-archives '(("gnu"    . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("nongnu" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/nongnu/")
                         ("melpa"  . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(package-initialize)
(use-package evil
  :config
  (setq evil-insert-state-cursor 'bar)
  (setq evil-emacs-state-cursor 'bar)
  )
(use-package spacemacs-theme
  :ensure t
  :no-require t
  :init (load-theme 'spacemacs-dark t))

;;(add-to-list 'default-frame-alist '(fullscreen . maximized))
;; (add-hook'c++-mode-common-hook(lambda()))
(delete-selection-mode)

;; 关闭备份文件、自动保存文件和欢迎界面，设置滚动边距和滚动行为
(setq make-backup-files nil)
(setq inhibit-splash-screen t)
(setq auto-save-default nil)
;; pixel-scroll-precision-mode 平滑滚动，与 scroll-margin/scroll-conservatively 冲突
(setq scroll-margin 3  scroll-conservatively 10000)
(pixel-scroll-precision-mode 1)

(display-time-mode 1) ;; 常显
(setq display-time-24hr-format t) ;;格式
(setq display-time-day-and-date t) ;;显示时间、星期、日期

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(use-package neotree
  :ensure t
  :init 
  (setq neo-window-fixed-size nil)
  (setq neo-window-width 20)
  )

(global-auto-revert-mode 1)

;; == Emacs 30 UI/QoL ==
(global-visual-wrap-prefix-mode 1)
(kill-ring-deindent-mode 1)
(minibuffer-regexp-mode 1)
(setq gud-highlight-current-line t)
;; Windows: 不跟随系统暗色模式 (保持主题颜色一致)
(when (eq system-type 'windows-nt)
  (setq w32-follow-system-dark-mode nil))

(fset 'yes-or-no-p 'y-or-n-p)

(setq default-directory "~/Desktop/Algorithm/")
(use-package window-numbering
  :ensure t
  :init (window-numbering-mode 1))
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

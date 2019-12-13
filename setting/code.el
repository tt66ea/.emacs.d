(setq gdb-many-windows t)
(load-library "multi-gud.el")
(load-library "multi-gdb-ui.el")

(global-auto-complete-mode t)
(global-company-mode 1)
(yas-global-mode 1);

(defun mycompile()
  (interactive)
  (save-buffer)
  (compile (format "g++ %S -o %S" (buffer-file-name) (concat (substring buffer-file-name 0 -4) ".exe")))
  );;clang++ -target x86_64-pc-windows-gnu name.cpp -o name.exe

(defun mycompile-gdb()
  (interactive)
  (save-buffer)
  (compile (format "g++ %S -g -o %S" (buffer-file-name) (concat (substring buffer-file-name 0 -4) ".exe")))
  );;clang++ -target x86_64-pc-windows-gnu name.cpp -o name.exe

(defun run()
  (interactive)
  (save-buffer)
  (shell-command "del tmp.bat")
  (shell-command "echo @echo off >> tmp.bat")
  (shell-command (format "echo %S.exe >> tmp.bat" (substring buffer-file-name 0 -4)))
  (shell-command "echo pause >> tmp.bat")
  (shell-command "echo exit >> tmp.bat")
  (shell-command "start tmp.bat")
  (shell-command "del tmp.bat")
) ; for Windows

(defun my:ac-c-header-init ()
    (require 'auto-complete-c-headers)
    (add-to-list 'ac-sources 'ac-source-c-headers)
    (add-to-list 'achead:include-directories '"C:/program Files (x86)/Dev-Cpp/MinGW64/lib/gcc/x86_64-w64-mingw32/4.9.2/include")
    (add-to-list 'achead:include-directories '"C:/Program Files (x86)/Dev-Cpp/MinGW64/lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++"))
(add-hook 'c++-mode-hook 'my:ac-c-header-init)
(add-hook 'c-mode-hook 'my:ac-c-header-init)

(require 'auto-complete-clang)
(setq ac-clang-flags
      (mapcar (lambda (item) (concat "-I" item))
              (split-string
               "
 C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++
 C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++/x86_64-w64-mingw32
 C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++/backward
 C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include
 C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/../../../../include
 C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include-fixed
 C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/../../../../x86_64-w64-mingw32/include
"
               )))

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq flycheck-checker-error-threshold 100)
(setq-default flycheck-disabled-checkers '(c/c++-clang))
(add-to-list 'display-buffer-alist
             `(,(rx bos "*Flycheck errors*" eos)
              (display-buffer-reuse-window
               display-buffer-in-side-window)
              (side            . bottom)
              (reusable-frames . visible)
              (window-height   . 0.33)))
(defun my-flymd-browser-function (url)
  (let ((process-environment (browse-url-process-environment)))
    (apply 'start-process
           (concat "google-chrome " url) nil
           "google-chrome"
           (list "--new-window" "--allow-file-access-from-files" url))))
(setq flymd-browser-open-function 'my-flymd-browser-function)

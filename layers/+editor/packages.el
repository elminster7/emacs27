;; packages.el --- editors configuration by elminster.


;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; windows
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; windows move bind key
(defun editor/winmove-init ()
  "w:indow move init"
  (use-package winmove
    :bind (("C-c <right>" . windmove-right)
	   ("C-c <left>" . windmove-left)
	   ("C-c <up>" . windmove-up)
	   ("C-c <down>" . windmove-down))))

;; nlinum function setting.
(defun editor/nlinum ()
  "nlinum install"
  (use-package nlinum
    :ensure t
    :init
    (require 'nlinum)
    (nlinum-mode 1)
    (set-face-foreground 'linum "#af8700")
    (setq nlinum-format "%4d\u2502")
    (global-hl-line-mode +1)
    (global-nlinum-mode t)
    (setq auto-window-vscroll nil)))

(defun editor/highlight-indent ()
  "highlight indent guides"
  (add-to-list 'load-path "~/.emacs.d/elpa/highlight-indent-guides/")
  (require 'highlight-indent-guides)
  (setq highlight-indent-guides-method 'character)
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode)
  (setq highlight-indent-guides-delay 10)
  (setq highlight-indent-guides-auto-odd-face-perc 15)
  (setq highlight-indent-guides-auto-even-face-perc 15)
  (setq highlight-indent-guides-auto-character-face-perc 20)
  (set-face-foreground 'highlight-indent-guides-character-face "gray"))

;; ▼ ECB
    (defun editor/ecb ()
      "ECB IDE init"
      (use-package ecb
	:ensure t
	:init (setq ecb-layout-name "left6")
	(setq ecb-examples-bufferinfo-buffer-name nil)
	(setq stack-trace-on-error t)
	(setq ecb-version-check nil)
	(setq ecb-compile-window-height 30)
	(setq ecb-windows-width 0.20)
	(bind-key "M-1" 'ecb-goto-window-sources)
	(bind-key "M-3" 'ecb-goto-window-history)
	(bind-key "M-2" 'ecb-goto-window-methods)
	(bind-key "M-0" 'ecb-goto-window-edit0)
	;; disable tip of the day
	(setq ecb-tip-of-the-day nil)
	;; semantic settings
	(semantic-mode t)
	;;	(set-face-background 'semantic-highlight-func-current-tag-face "blue")
;;	(set-face-background 'semantic-highlight-func-current-tag-face "brightred")
;;	(set-face-foreground 'semantic-highlight-func-current-tag-face "black")
	(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;;	(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)
;;	(global-semanticdb-minor-mode t)
	(global-semantic-stickyfunc-mode t)
	(global-semantic-highlight-func-mode t)
	(global-semantic-decoration-mode t)
	:bind 	("C-c h" . 'ecb-toggle-compile-window)))

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; edit
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; symbol function imenu
(defun editor/popup-imenu ()
  "symbol function for imenu."
  (use-package popup-imenu
    :ensure t
    :bind (("C-f" . popup-imenu))))

(defun editor/linux-c-indent ()
  "adjusted defaults for C/C++ mode use with the Linux kernel."
  (interactive)
  (setq indent-tabs-mode nil) 
  (add-hook 'c-mode-hook (lambda() (c-set-style "K&R")))
  (setq c-basic-offset 8))

;; dired settings
(defun editor/dired-settings ()
  "dired copy setting."
  (setq dired-dwim-target t)
  (bind-key "C-h" 'find-name-dired))

;; auto-highlight-symbol
(defun editor/auto-highlight-symbol ()
  "thils only installs it for programming mode derivatives. you can also makeit global.."
  (use-package auto-highlight-symbol
    :ensure t
    :init (add-hook 'prog-mode-hook 'highlight-symbol-mode)
    (global-auto-highlight-symbol-mode t)
    :bind (:map auto-highlight-symbol-mode-map
                ("M-p" . ahs-backward)
                ("M-n" . ahs-forward))))

(defun editor/white-space ()
  "white space column"
  (setq-default
   whitespace-line-column 80
   whitespace-style       '(face lines-tail)))

(defun editor/default-env ()
  "default env"
  (fset 'yes-or-no-p 'y-or-n-p)
  (setq coding-system-for-read 'utf-8)
  (setq coding-system-for-write 'utf-8)
  (set-language-environment "UTF-8")

  (editor/white-space)
  
  (setq auto-mode-alist
	  (cons '("\\.mak\\'" . makefile-mode) auto-mode-alist))
  (setq auto-mode-alist
	(cons '("\\.bb\\'" . makefile-mode) auto-mode-alist))
  (setq auto-mode-alist
	(cons '("\\.inc\\'" . makefile-mode) auto-mode-alist))
  (setq auto-mode-alist
	(cons '("Makefile" . makefile-mode) auto-mode-alist))
  (setq auto-mode-alist
	(cons '("\\.conf\\'" . makefile-mode) auto-mode-alist)))

;; ripgrep search
(defun editor/ripgrep ()
  "ripgrep init"
  (use-package ripgrep
    :ensure t
    :bind (("C-p" . ripgrep-regexp))))

;; editor init
(defun editor/function_init ()
  "editor preference settings init"
  (editor/auto-highlight-symbol)
  (editor/highlight-indent)
  (editor/winmove-init)
  (editor/nlinum)
  (editor/dired-settings)
  (editor/linux-c-indent)
  (editor/popup-imenu)
  (editor/ecb)
  (editor/default-env)
  (editor/ripgrep))

(defun editor/init ()
  (editor/function_init))

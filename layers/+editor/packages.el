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
  (set-face-foreground 'highlight-indent-guides-character-face "dimgray"))

;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; edit
;;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;; symbol function imenu
(defun editor/popup-imenu ()
  "symbol function for imenu."
  (use-package popup-imenu
    :ensure t
    :bind (("C-f" . popup-imenu))))

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

;; ripgrep search
(defun editor/ripgrep ()
  "ripgrep init"
  (use-package ripgrep
    :ensure t
    :bind (("C-p" . ripgrep-regexp))))

;; editor init
(defun editor/function_init ()
  "editor preference settings init"
  (editor/highlight-indent)
  (editor/winmove-init)
  (editor/nlinum)
  (editor/dired-settings)
  (editor/popup-imenu)
  (editor/ripgrep))

(defun editor/init ()
  (editor/function_init))

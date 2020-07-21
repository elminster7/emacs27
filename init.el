;; elminster emacs configuration init.el.
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

(when (version< emacs-version "27.0")
  (error "babel requires at least GNU Emacs 27.0"))

(defvar emacs-dir (file-name-directory load-file-name)
	"The root dir of the Emacs babel distribution.")
(defvar emacs-core-dir (expand-file-name "core" emacs-dir)
  "The home of babel's core functionality.")

;; hide the startup message
(setq inhibit-startup-message t)

;; add babel's directories to Emacs's `load-path'
(add-to-list 'load-path emacs-core-dir)

;; the core stuff
(require 'core-emacs)
(require 'core-packages)

(emacs/init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(spacemacs-dark))
 '(custom-safe-themes
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "67ea2e2549ab1ba9b27a4fc3c78353225d6fd155a69292dc6f7d3286bd8d3a82" "f4c8f0b999a6407211a899401315a628e1a5ae2f408c04a33b14d7aa3ed86187" "31f8d16d264e14e8e39c4f291e26cdd5516772a41660ef2ad895244c22024bd2" default))
 '(lsp-auto-guess-root t)
 '(lsp-enable-snippet nil)
 '(lsp-prefer-flymake nil t)
 '(package-selected-packages
   '(spacemacs-theme sr-speedbar vscode-dark-plus-theme warm-night-theme helm-evil-markers helm-gtags eglot lsp-mode company-lsp magit vscdark-theme function-args equake vimish-fold evil-visual-mark-mode popwin counsel-projectile avy avy-menu yequake ecb minibuf-isearch neotree ripgrep elgrep popup-imenu e2wm multiple-cursors xcscope counsel-gtags ivy use-package))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "PragmataPro for Powerline" :foundry "fsdf" :slant normal :weight normal :height 98 :width normal))))
 '(font-lock-function-name-face ((t (:foreground "brightblue" :weight bold :height 1.0)))))

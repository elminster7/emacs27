;; packages.el --- tools packages for elminster.

;; ivy is an interactive interface for completion.
;; counsel package include ivy, bind-key, swiper.
(defun tools/ivy ()
  "interactive interface for completion."
  (use-package ivy 
    :ensure t
    :init
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-count-format "(%d/%d) ")
    :bind (("C-s" . swiper-all-thing-at-point)
	   ("C-c C-r" . ivy-resume)
	   )))

;; counsel
(defun tools/counsel ()
  "interface counsel package"
  (use-package counsel
    :ensure t
    :init
    :bind (("M-x" . counsel-M-x)
	   ("C-x C-f" . counsel-find-file)
	   ("C-c c" . counsel-compile)
	   ("C-c g" . counsel-git)
	   ("C-c j" . counsel-git-grep)
	   ("C-c k" . counsel-ag)
	   ("C-b" . counsel-buffer-or-recentf)
	   ("C-x l" . counsel-locate)
	   ("≈" . counsel-M-x))))

;; tools ivy-rtags
(defun tools/ivy-rtags ()
  "company rtags"
  (use-package ivy-rtags
    :ensure t
    :hook ((c++-mode . rtags-start-process-unless-running)
    (c-mode . rtags-start-process-unless-running))
    :config (setq rtags-completions-enabled t
		  rtags-path "/home/elminster/.emacs.d/elpa/rtags-20200221.36/rtags.el"
		  rtags-rc-binary-name "/usr/local/bin/rc"
		  rtags-use-ivy t
		  rtags-rdm-binary-name "/usr/local/bin/rdm")
    :bind (("M-." . rtags-find-symbol-at-point)
	   ("M-," . rtags-find-symbol)
	   ("M-r" . rtags-find-references-at-point)
;	   ("C-o" . rtags-find-references-at-point)
;	   ("M-s" . rtags-find-file)
;	   ("C-v" . rtags-find-virtuals-at-point)
;	   ("C-F" . rtags-fixit)
	   ("M-]" . rtags-location-stack-forward)
	   ("M-[" . rtags-location-stack-back)
;	   ("C-n" . rtags-next-match)
;	   ("C-p" . rtags-previous-match)
;	   ("C-P" . rtags-preprocess-file)
;	   ("C-R" . rtags-rename-symbol)
	   ("M-s" . rtags-show-rtags-buffer)
	   ("M-t" . rtags-print-symbol-info))
;	   ("C-t" . rtags-symbol-type)
;	   ("C-I" . rtags-include-file)
;	   ("C-i" . rtags-get-include-file-for-symbol))
    :init (setq rtags-display-result-backend 'ivy)
    (add-hook 'c-mode-hook 'xcscope-mode)
    (add-hook 'c++-mode-hook 'xcscope-mode)
    (add-hook 'asm-mode-hook 'xcscope-mode)))

;; lsp mode
(defun tools/lsp-mode ()
  "lsp mode"
  (use-package lsp-mode
  :commands lsp
  :ensure t))

(defun tools/lsp-ui ()
  "lsp mode"
  (use-package lsp-ui
    :commands lsp-ui-mode
    :ensure t))

(defun tools/company-lsp ()
  "company lsp"
  (use-package company-lsp
  :ensure t
  :commands company-lsp
  :config (push 'company-lsp company-backends)))

(defun tools/ccls ()
  (use-package ccls
  :ensure t
  :config
  (setq ccls-executable "ccls")
  (setq lsp-prefer-flymake nil)
  (setq-default flycheck-disabled-checkers '(c/c++-clang c/c++-cppcheck c/c++-gcc))
  :hook ((c-mode c++-mode) .
	 (lambda () (require 'ccls)(lsp)))))

(defun tools/init ()
  (tools/counsel)
  (tools/ivy-rtags)
  (tools/ivy)
  (tools/lsp-mode)
  (tools/lsp-ui)
  (tools/company-lsp)
  (tools/ccls))

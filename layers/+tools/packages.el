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
	   ("C-c C-r" . ivy-resume))))

(defun tools/multiplecursor ()
  "Multiple Cursor Init"
  (use-package multiple-cursors
    :ensure t
    :bind (("C-l" . mc/edit-lines)
           ("C-;" . mc/mark-all-like-this)
           ("C-'" . mc/mark-all-words-like-this))))

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

(defun tools/init-xcscope ()
  "cscope package install"
  (use-package xcscope
    :ensure t
    :init
    (add-hook 'c-mode-hook 'xcscope-mode)
    (add-hook 'c++-mode-hook 'xcscope-mode)
    (add-hook 'asm-mode-hook 'xcscope-mode)
    :bind
    (("C-c c" . cscope-find-functions-calling-this-function)
     ("C-c ]" . cscope-find-global-definition)
     ("C-c [" . cscope-pop-mark)
     ("C-c t" . cscope-find-this-text-string)
     ("C-c n" . cscope-find-egrep-pattern))))

(defun tools/counsel-gtags ()
  "counsel gtags"
  (use-package counsel-gtags
    :ensure t
    :init
    (add-hook 'c++-mode-hook 'counsel-gtags-mode)
    (add-hook 'php-mode-hook 'counsel-gtags-mode)
    :bind (("M-g ." . counsel-gtags-dwim)
	   ("M-g t" . counsel-gtags-pop-stack)
	   ("M-g r" . counsel-gtags-find-tags)
	   ("M-g s" . counsel-gtags-find-symbol)
	   ("M-g [" . counsel-gtags-previous-history)
	   ("M-g ]" . counsel-gtags-next-history))))

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
    :init (setq rtags-display-result-backend 'ivy)))

;; lsp mode
(defun tools/lsp-mode ()
  "lsp mode"
  (use-package lsp-mode
    :ensure t
    :config (require 'lsp-mode)))

(defun tools/lsp-ui ()
  "lsp mode"
  (use-package lsp-ui))


(defun tools/company-lsp ()
  "company lsp"
  (use-package company-lsp
  :ensure t
  :config ((require 'company-lsp)
	   (push 'company-lsp company-backends)
	   (add-hook 'after-init-hook 'global-company-mode))

(defun tools/lsp-clangd ()
  (setq lsp-clients-clangd-executable "/usr/lib/llvm-9/bin/clangd")
  (add-hook 'c-mode-hook #'lsp-clangd-c-enable)
  (add-hook 'c++-mode-hook #'lsp-clangd-c++-enable))

;; ▼ bind keymapping for tool.
(defun tools/manual-to-man ()
  "shortcut manual key for man"
  (bind-key "C-c /" 'man-follow))

(defun tools/bind-key ()
  "expanded bind key settings."
  (bind-key "C-c s" 'lsp)
  (bind-key "C-c u" 'lsp-ui-sideline-toggle-symbols-info)
  (bind-key "C-c r" 'lsp-ui-peek-find-references))

;; helm-lsp flycheck
(defun tools/init ()
  (tools/counsel)
  (tools/ivy-rtags)
  (tools/ivy)
  (tools/lsp-mode)
  (tools/lsp-ui)
  (tools/company-lsp)
  (tools/init-xcscope)
  (tools/multiplecursor)
  (tools/counsel-gtags)
  (tools/bind-key)
  (tools/lsp-clangd))

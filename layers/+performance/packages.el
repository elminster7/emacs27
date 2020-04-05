;; packages.el --- performance for elminster.

(defun performance/lsp-tuning ()
  "lsp client/server communication generates a log of memory/gabage."
  (setq gc-cons-threshold 100000000)
  (setq read-process-output-max (* 1024 2048)))

(defun performance/init ()
  (performance/lsp-tuning))

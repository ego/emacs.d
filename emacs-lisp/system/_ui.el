;; User interface

;; theme
(add-to-list 'custom-theme-load-path emacs-themes)


(use-package zenburn-theme 
  :init
  ;; personal color
  (defvar zenburn-override-colors-alist
    '(("zenburn-yellow" . "#93E0E3")))
  (load-theme 'zenburn t))


(provide '_ui)

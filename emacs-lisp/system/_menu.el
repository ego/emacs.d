;;
;; TODO: some function do not work(

(use-package menu-bar+
  :doc "The order is very match!"
  :no-require t
  :after 'menu-bar
  :init
  ;; before loads menu-bar+
  (use-package second-sel)
  (use-package doremi)  
  (use-package help+)
  (use-package help-fns+)
  (use-package thumb-frm)
  (use-package doremi-frm)
  (use-package doremi-cmd)
  (use-package doremi-mac)
  (use-package facemenu+)
  (use-package eyedropper)
  (use-package highlight)
  (use-package ring)
  (use-package zoom-frm)
  (use-package frame-cmds)
  (use-package hexrgb)
  (use-package cmds-menu)
  (use-package fit-frame)

  :config
  (tooltip-mode  1)
  (tool-bar-mode -1)
  (menu-bar-mode -1)
  (global-set-key [f10] 'toggle-menu-bar-mode-from-frame))


(require 'unaccent)
(use-package unaccent 
  :doc "Edit, fix text"
  :ensure f
  :load-path emacs-vendor
  :commands R)


(provide '_menu)

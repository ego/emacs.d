;;; GNU Emacs user system
;;; env HOME=$HOME/Dropbox/emacs/emacs_system emacs25.1 --daemon 

;;; emacsclient -c
;;; emacsclient -t

;;; env HOME=$HOME/Dropbox/emacs/emacs_system emacs25.1 --debug-init

;;; -> .zshrc .bashrc
;;; alias e=emacsclient -t
;;; alias ec=emacsclient -c
;;; alias vim=emacsclient -t
;;; alias vi=emacsclient -t


;;; Profiling
(defvar *emacs-load-start* (current-time))
(defun anarcat/time-to-ms (time)
  (+ (* (+ (* (car time) (expt 2 16)) 
           (car (cdr time))) 1000000) 
     (car (cdr (cdr time)))))

(defun anarcat/display-timing ()
  (message "Done, emacs user systen loaded in: %f ms" 
           (/ (- (anarcat/time-to-ms (current-time)) (anarcat/time-to-ms *emacs-load-start*)) 1000000.0)))
(add-hook 'after-init-hook 'anarcat/display-timing t)
;;;


;; This must come before configurations of installed packages.
(package-initialize)


(defun system-is-darwin()
  (string-equal system-type "darwin"))

(defun system-is-linux()
  (string-equal system-type "gnu/linux"))

(defun system-is-windows()
  (string-equal system-type "windows-nt"))

(defvar current-user
  (getenv
   (if (system-is-windows) "USERNAME" "USER")))


;; Load vars and set load path
(defvar emacs-root-dir (file-name-directory load-file-name)
  "The init file directory")

(load-file (concat (file-name-directory load-file-name) 
                   "emacs-lisp/system/_varboot.el"))

(message "Emacs version %s" emacs-version)
(message "Have a nice day coder %s!" current-user)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ido-grid-mode-match ((t (:background "dark violet" :underline "dark violet")))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/resources/bookmark/bookmark")
 '(package-selected-packages
   (quote
    (wavefront-obj-mode json-mode jsx-mode js2-mode eslint-fix clojurescript-mode clojure-snippets flycheck-clojure clj-refactor cider company-anaconda anaconda-mode zoom-frm zenburn-theme which-key web-mode volatile-highlights visual-regexp use-package undo-tree thumb-frm smex second-sel rainbow-mode rainbow-delimiters persp-projectile paredit menu-bar+ markdown-mode magit keyfreq key-chord imenu-anywhere imenu+ idomenu ido-yes-or-no ido-ubiquitous ido-grid-mode ido-describe-bindings ido-complete-space-or-hyphen ido-clever-match ido-at-point hydra highlight-parentheses highlight help-fns+ help+ guide-key goto-last-change god-mode go-mode ggtags free-keys flx-ido fit-frame facemenu+ f eyedropper emmet-mode edit-server doremi-mac doremi-frm doremi-cmd diff-hl dashboard crm-custom company-web company-tern company-flx company-edbi cmds-menu clojure-mode bookmark+ bm anzu aggressive-indent ace-window))))

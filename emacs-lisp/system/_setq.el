;; set different values


(setq package-enable-at-startup nil 	;; don't initialize later as well
      load-prefer-newer t           	;; always load newest byte code
      package-user-dir emacs-site-lisp
      backup-directory-alist `(("." . , user-backups))
      auto-save-file-name-transforms `((".*" , user-auto-save t))
      tramp-auto-save-directory user-auto-save)

(unless (file-exists-p user-backups) (make-directory user-backups))

(setq ido-save-directory-list-file user-ido)

;; use-package autoinstall if noy that package
(setq use-package-verbose t
      use-package-always-ensure t)

;; Emacs auto-refresh all buffers when files have changed on disk.
(global-auto-revert-mode t)

;; Set encoding
(prefer-coding-system 				'utf-8)
(define-coding-system-alias 'UTF-8 	'utf-8)
(define-coding-system-alias 'utf8 	'utf-8)

;; makes killing/yanking interact with the clipboard
(setq x-select-enable-clipboard 		  t 
      save-interprogram-paste-before-kill t
      mouse-yank-at-point 				  t)

(setq-default truncate-lines     t)  		;; No word wrap
(setq-default indent-tabs-mode nil)			;; Don't use tabs for indent

(setq fill-column 				 80         ;; M-q
      show-trailing-whitespace 	  t         ;; Show extra whitespace
      require-final-newline       t 		;; Ensure last line is a return
      sentence-end-double-space nil) 		;; Sentences end with single space

(subword-mode          t)					;; camelCase
(delete-selection-mode t) 					;; Delete selection, insert text
(show-paren-mode       t)					;; Show-paren-mode settings, selections in {},[],()
(setq show-paren-style 'expression)			;; Color for selections {},[],()

(setq read-file-name-completion-ignore-case t ;; Improve filename completion
      read-buffer-completion-ignore-case 	t)
(mapc (lambda (x)
        (add-to-list 'completion-ignored-extensions x))
      '(".gz" ".pyc" ".elc" ".exe"))

(setq ad-redefinition-action 'accept		;; Suppress warnings for functions redefined with defadvice
      tab-always-indent 	 'complete)		;; Smart tab behavior - indent or complete

(require 'font-lock)						;; Подсветка кода
(global-font-lock-mode             t) 
(setq font-lock-maximum-decoration t)

(setq search-highlight        t 			;; Выделять результаты поиска
      query-replace-highlight t)

;; hippie expand is dabbrev expand on steroids
(setq hippie-expand-try-functions-list '(try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-complete-file-name-partially
                                         try-complete-file-name
                                         try-expand-all-abbrevs
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))

(setq tab-always-indent 'complete)			;; smart tab behavior - indent or complete

(setq blink-matching-paren nil)				;; disable annoying blink-matching-paren

;; windows

(defadvice split-window (after move-point-to-new-window activate)
  "Moves the point to the newly created window after splitting."
  (other-window 1))


;; Mac OS
;; http://jblevins.org/log/kbd
;; http://ergoemacs.org/emacs/emacs_hyper_super_keys.html
;; http://lists.gnu.org/archive/html/help-gnu-emacs/2011-02/msg00019.html
;; https://www.emacswiki.org/emacs/MacKeyMode

;; Mac Os specific settings
(when (eq system-type 'darwin)

  (set-terminal-coding-system 'utf-8)
  (set-keyboard-coding-system 'utf-8)
  (prefer-coding-system 'utf-8)

  ;; mac specific settings
  (global-set-key [kp-delete] 'delete-char)   ; Fn-delete to be right-delete

  (setq mac-control-modifier  'control        ; Control = Ctrl
        mac-command-modifier  'meta           ; Cmd = Alt Meta M
        mac-option-modifier   'super          ; Option Alt = Super
        mac-function-modifier 'hyper          ; Fn key do Hyper
        ns-function-modifier  'hyper          ; Fn key do Hyper

        mac-right-command-modifier 'control   ; right Cmd = Ctr 
        mac-right-option-modifier  'alt       ; right Option = Alt
))


;; Only one's
(custom-set-faces
 '(ido-grid-mode-match ((t (:background "dark violet" :underline "dark violet")))))


(provide '_setq)

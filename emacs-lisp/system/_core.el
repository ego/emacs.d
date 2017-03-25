;;

(use-package ido
  :doc "Это основной трюк воизбежания minibuffer-complete
   http://emacsist.com/10480"
  :init 
  ;; make compiler hapy
  (defvar ido-directory-too-big nil)
  (defvar ido-directory-nonreadable nil)
  (defvar ido-choice-list nil)
  (defvar ido-temp-list nil)
  (defvar ido-cur-item nil)

  (setq ido-enable-prefix t
        ido-use-virtual-buffers t
        ido-use-filename-at-point 'guess
        ido-ignore-extensions t
        ido-max-directory-size 100000
        ido-default-buffer-method 'selected-window
        ido-auto-merge-work-directories-length -1)
  :config
  (ido-mode 1)
  (ido-everywhere 1)
  (add-hook 'ido-setup-hook 
            (lambda () 
              (define-key ido-completion-map [tab] 'ido-complete)))

  (add-to-list 'completion-ignored-extensions ".pyc")

  ;; http://www.reddit.com/r/emacs/comments/21a4p9/use_recentf_and_ido_together/cgbprem
  ;; История комманд отображается сразу при нажатии M-x,
  (add-hook 'ido-setup-hook (lambda () 
                              (define-key ido-completion-map [C-up] 'previous-history-element)))

  (use-package ido-at-point
    :doc "https://github.com/katspaugh/ido-at-point"
    :config (ido-at-point-mode))

  (use-package crm-custom
    :doc "https://github.com/DarwinAwardWinner/crm-custom"
    :config (crm-custom-mode 1))

  (use-package ido-ubiquitous 
    :doc "https://github.com/DarwinAwardWinner/ido-ubiquitous"
    :init (setq gnus-completing-read-function 'gnus-ido-completing-read)
    :config (ido-ubiquitous-mode t))

  (use-package ido-yes-or-no  :config (ido-yes-or-no-mode 1)))

(use-package flx-ido
  :doc "https://github.com/lewang/flx"
  :init
    (setq ido-enable-flex-matching t
          ido-use-faces nil
          ido-show-dot-for-dired nil
          ido-enable-dot-prefix t)
  :config
    (flx-ido-mode 1))

(use-package ido-clever-match
  :doc "https://github.com/Bogdanp/ido-clever-match"
  :config
  (ido-clever-match-enable))

(use-package ido-complete-space-or-hyphen
  :doc "https://github.com/doitian/ido-complete-space-or-hyphen")

(use-package smex
  :doc "https://github.com/nonsequitur/smex"
  :hot-key "smex-show-unbound-commands | M-. | C-h w | C-h f"
  :init
  (setq smex-save-file user-smex-items)
  (smex-initialize)
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  
  (setq savehist-file user-savehist)
  (savehist-mode 1)
  
  (setq smex-history-length 100)
  
  :config
  ;; https://www.emacswiki.org/emacs/Smex
  (defun smex-update-after-load (unused)
    (when (boundp 'smex-cache)
      (smex-update)))
  (add-hook 'after-load-functions 'smex-update-after-load)
  ;; TODO: do not work
  ;; https://github.com/nonsequitur/smex/blob/master/smex.el#L154
                                        ; (defun h/advise-smex-bindings ()
                                        ;   (define-key ido-completion-map (kbd "<tab>") 'ido-complete))
                                        ; (advice-add 'smex-prepare-ido-bindings :after #'h/advise-smex-bindings)
  )

; Хороший, маленький простой пакет! Альтернатива к ido-grid-mode
; (use-package ido-vertical-mode
;   :doc "Good! It works!
;   https://github.com/creichert/ido-vertical-mode.el"
;   :ensure t
;   :init
;   (ido-mode 1)
;   (ido-vertical-mode 1)
;   (setq ido-vertical-show-count t)
;   (setq ido-vertical-define-keys 'C-n-C-p-up-down-left-right)

;   :config
;   (setq ido-use-faces t)
;   (set-face-attribute 'ido-vertical-first-match-face nil
;                     :background nil
;                     :foreground "orange")
;   (set-face-attribute 'ido-vertical-only-match-face nil
;                     :background nil
;                     :foreground nil)
;   (set-face-attribute 'ido-vertical-match-face nil
;                     :foreground nil))

(use-package ido-grid-mode
  :doc "I like it!
   https://github.com/larkery/ido-grid-mode.el
   Another one:
   https://github.com/larkery/ido-grid.el"
  :init
  (ido-grid-mode 1)
  (setq ido-grid-mode-max-rows 8
        ido-grid-mode-min-rows 4
  	    ido-grid-mode-match t
  	    ido-subdir t
        ido-grid-mode-prefix-scrolls t
      	ido-grid-mode-scroll-down #'ido-grid-mode-next-row
      	ido-grid-mode-scroll-up #'ido-grid-mode-previous-row
      	; ido-grid-mode-start-collapsed t ;; Компактный вид в одну строчку
        ido-grid-mode-order nil)
  ;; custom colors for ido
  :config
  ;; Make projectile-find-file vertical list
  (defun ido-vertical-please (o &rest args)
    (let ((ido-grid-mode-max-columns 2)
          (ido-grid-mode-max-rows 15) ;; bigger list than usual
          (ido-grid-mode-min-rows 1) ;; let it shrink
          (ido-grid-mode-start-collapsed nil) ;; pop up tall at the start
          ;; why not have a different prefix as well?
          (ido-grid-mode-prefix "> "))
      (apply o args)))
  (advice-add 'projectile-find-file :around #'ido-vertical-please))

(use-package org
  :doc "For text files"
  :init
  (setq org-completion-use-ido t
        org-outline-path-complete-in-steps nil))

(use-package god-mode
  :doc "https://github.com/chrisdone/god-mode
   Позволяет сократить нажатие клавиш избегаю дублировани С | M
   Что то похожее на hydra.
   Работает это так - нажимаем escape и понеслась x -f и это будет C-x C-f"
  :tag "key hydra"
  :hot-key "escape"
  :init
  (setq god-exempt-major-modes nil)
  (setq god-exempt-predicates nil)
  :config 
  (global-set-key (kbd "<escape>") 'god-local-mode)
  (global-set-key (kbd "<escape>") 'god-mode-all)

  (defun my-update-cursor ()
    (setq cursor-type (if (or god-local-mode buffer-read-only)
                          'box
                        'bar)))
  (add-hook 'god-mode-enabled-hook 'my-update-cursor)
  (add-hook 'god-mode-disabled-hook 'my-update-cursor)

  (defun c/god-mode-update-cursor ()
    (let ((limited-colors-p (> 257 (length (defined-colors)))))
      (cond (god-local-mode (progn
                              (set-face-background 'mode-line (if limited-colors-p "white" "#e9e2cb"))
                              (set-face-background 'mode-line-inactive (if limited-colors-p "white" "#e9e2cb"))))
            (t (progn
                 (set-face-background 'mode-line (if limited-colors-p "black" "#0a2832"))
                 (set-face-background 'mode-line-inactive (if limited-colors-p "black" "#0a2832")))))))

  (defun god-toggle-on-overwrite ()
    "Toggle god-mode on overwrite-mode."
    (if (bound-and-true-p overwrite-mode)
        (god-local-mode-pause)
      (god-local-mode-resume)))
  (add-hook 'overwrite-mode-hook 'god-toggle-on-overwrite)

  (define-key god-local-mode-map [remap self-insert-command] 'my-god-mode-self-insert)
  (defun my-god-mode-self-insert ()
    (interactive)
    (if (and (bolp)
             (eq major-mode 'org-mode))
        (call-interactively 'org-self-insert-command)
      (call-interactively 'god-mode-self-insert)))

  (require 'god-mode-isearch)
  (define-key isearch-mode-map (kbd "<escape>") 'god-mode-isearch-activate)
  (define-key god-mode-isearch-map (kbd "<escape>") 'god-mode-isearch-disable)
  ) 


; (use-package desktop
;  :init
;  (setq desktop-dirname         user-desktop-dirname
;        desktop-base-file-name  user-desktop-file-name)

;  :config
;   ; (setq history-length 250)
;   ; (add-to-list 'desktop-globals-to-save 'file-name-history)
;  (desktop-save-mode 1)

;   ; (setq desktop-buffers-not-to-save
;   ;       (concat "\\("
;   ;               "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
;   ;               "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
;   ;         "\\)$"))
;   ;  (add-to-list 'desktop-modes-not-to-save 'dired-mode)
;   ;  (add-to-list 'desktop-modes-not-to-save 'Info-mode)
;   ;  (add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
;   ;  (add-to-list 'desktop-modes-not-to-save 'fundamental-mode)
;  )

;; (setq debug-on-error t)
;; (desktop-save-mode 1)


(setq desktop-dirname         user-desktop-dirname
      desktop-base-file-name  user-desktop-file-name)

(defun saved-session ()
  (file-exists-p user-desktop-file-name))

;; use session-restore to restore the desktop manually
(defun session1-restore ()
  "Restore a saved emacs session."
  (interactive)
  (if (saved-session)
      (desktop-read)
    (message "No desktop found.")))

;; use session-save to save the desktop manually
(defun session1-save ()
  "Save an emacs session."
  (interactive)
  (if (saved-session)
      (if (y-or-n-p "Overwrite existing desktop? ")
    (desktop-save-in-desktop-dir)
  (message "Session not saved."))
  (desktop-save-in-desktop-dir)))

;; ask user whether to restore desktop at start-up
; (add-hook 'after-init-hook
;     '(lambda ()
;        (if (saved-session)
;      (if (y-or-n-p "Restore desktop? ")
;          (session-restore)))))


(provide '_core)

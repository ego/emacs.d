;; programirring

(use-package ggtags
  :doc "https://github.com/leoliu/ggtags"
  :diminish ggtags-mode
  :config
  (add-hook 'prog-mode-hook (lambda () (ggtags-mode 1))))

(use-package ediff 
  :config
  (setq ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package magit 
  :init
  (setq magit-completing-read-function #'magit-ido-completing-read))

(use-package imenu)

(use-package imenu+
  :init (add-hook 'prog-mode-hook 'imenup-add-defs-to-menubar)
  (add-hook 'org-mode-hook  'imenup-add-defs-to-menubar))

(use-package idomenu
  :bind (("C-x C-i" . idomenu)))

(use-package imenu-anywhere
  :bind (("C-." . imenu-anywhere)))

(use-package bookmark
  :doc "https://www.emacswiki.org/emacs/BookMarks
   bookmarks"
  :tag "bookmarks"
  :init
  (setq bookmark-default-file user-bookmark
        bookmark-file         user-bookmark 
        bookmark-save-flag                1))

(use-package bookmark+ 
  :doc "https://www.emacswiki.org/emacs/BookmarkPlus#Bookmark%2b"
  :init
  (setq bmkp-default-bookmark-file       user-bookmark
        bmkp-last-as-first-bookmark-file user-bookmark))

(use-package bm
  :demand t
  :init
  ;; restore on load (even before you require bm)
  (setq bm-restore-repository-on-load t)
  :config
  ;; Allow cross-buffer 'next'
  (setq bm-cycle-all-buffers t)
  ;; where to store persistant files
  (setq bm-repository-file (expand-file-name "bm-repository" user-bookmark))
  ;; save bookmarks
  (setq-default bm-buffer-persistence t)
  ;; Loading the repository from file when on start up.
  (add-hook' after-init-hook 'bm-repository-load)
  ;; Restoring bookmarks when on file find.
  (add-hook 'find-file-hooks 'bm-buffer-restore)
  ;; Saving bookmarks
  (add-hook 'kill-buffer-hook #'bm-buffer-save)
  ;; Saving the repository to file when on exit.
  ;; kill-buffer-hook is not called when Emacs is killed, so we
  ;; must save all bookmarks first.
  (add-hook 'kill-emacs-hook #'(lambda nil
                                 (bm-buffer-save-all)
                                 (bm-repository-save)))
  ;; The `after-save-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state.
  (add-hook 'after-save-hook #'bm-buffer-save)
  ;; Restoring bookmarks
  (add-hook 'find-file-hooks   #'bm-buffer-restore)
  (add-hook 'after-revert-hook #'bm-buffer-restore)
  ;; The `after-revert-hook' is not necessary to use to achieve persistence,
  ;; but it makes the bookmark data in repository more in sync with the file
  ;; state. This hook might cause trouble when using packages
  ;; that automatically reverts the buffer (like vc after a check-in).
  ;; This can easily be avoided if the package provides a hook that is
  ;; called before the buffer is reverted (like `vc-before-checkin-hook').
  ;; Then new bookmarks can be saved before the buffer is reverted.
  ;; Make sure bookmarks is saved before check-in (and revert-buffer)
  (add-hook 'vc-before-checkin-hook #'bm-buffer-save)

  ;; https://www.emacswiki.org/emacs/TrackChanges
  (highlight-changes-mode 1)

  :bind (("<f2>" .   bm-next)
         ("S-<f2>" . bm-previous)
         ("C-<f2>" . bm-toggle)))

(use-package company
  :doc "http://company-mode.github.io"
  :hot-key "C-s | C-r | C-o | C-w | f1"
  :init 
  ;; TODO: test
  (setq company-echo-delay 0
        company-idle-delay 0.8
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t
        company-tooltip-limit 20)
  
  :config

  (use-package company-flx
    :doc "https://github.com/PythonNut/company-flx"
    :config 
    (company-flx-mode +1))

  

  (global-set-key [C-tab] #'company-complete)
  (global-set-key (kbd "TAB") #'company-indent-or-complete-common)
  ;; TODO: test it
  (add-hook 'after-init-hook 'global-company-mode))

;; TODO
;; https://github.com/company-mode/company-mode/wiki/Third-Party-Packages
(use-package company-tern
  :doc "https://github.com/proofit404/company-tern
    Company JavaScript"
  :config
  (add-to-list 'company-backends 'company-tern))

(use-package company-edbi
  :doc "https://github.com/proofit404/company-edbi
    SQL JavaScript"
  :config
  (add-to-list 'company-backends 'company-edbi))

(use-package web-mode)

(use-package company-web
  :doc "https://github.com/osv/company-web
    SQL JavaScript"
  :config
  (defun my-web-mode-hook ()
    "Hook for `web-mode'."
    (set (make-local-variable 'company-backends)
         '(company-tern company-web-html company-yasnippet company-files)))

  (add-hook 'web-mode-hook 'my-web-mode-hook)

  ;; Enable JavaScript completion between <script>...</script> etc.
  (defadvice company-tern (before web-mode-set-up-ac-sources activate)
    "Set `tern-mode' based on current language before running company-tern."
    (message "advice")
    (if (equal major-mode 'web-mode)
        (let ((web-mode-cur-language
               (web-mode-language-at-pos)))
          (if (or (string= web-mode-cur-language "javascript")
                  (string= web-mode-cur-language "jsx")
                  )
              (unless tern-mode (tern-mode))
            (if tern-mode (tern-mode -1)))))))

;; manual autocomplete
(define-key web-mode-map (kbd "C-TAB") 'company-complete)

(use-package aggressive-indent
  :config
  (add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  (add-hook 'css-mode-hook #'aggressive-indent-mode))

(use-package highlight-parentheses
  :config
  (highlight-parentheses-mode 1))

(use-package anzu
  :doc "https://github.com/syohex/emacs-anzu"
  :config 
  (global-anzu-mode +1)
  (global-set-key [remap query-replace] 'anzu-query-replace)
  (global-set-key [remap query-replace-regexp] 'anzu-query-replace-regexp))

(use-package goto-last-change
  :doc "https://www.emacswiki.org/emacs/goto-last-change.el"
  :config
  (global-set-key "\C-x\C-\\" 'goto-last-change))

(use-package diff-hl
  :doc "https://github.com/dgutov/diff-hl"
                                        ; :init
                                        ;   (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
                                        ;   (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
  :config
  (defadvice svn-status-update-modeline (after svn-update-diff-hl activate)
    (diff-hl-update))
  (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
  (global-diff-hl-mode))

(use-package rainbow-mode
  :diminish rainbow-mode
  :config
  (rainbow-mode 1)
  (add-hook 'clojure-mode-hook 'rainbow-mode)
  (add-hook 'css-mode-hook 'rainbow-mode)
  (add-hook 'html-mode-hook 'rainbow-mode)
  (add-hook 'prog-mode-hook 'rainbow-mode))

(use-package rainbow-delimiters
  :config
  (rainbow-delimiters-mode 1)
  (add-hook 'clojure-mode-hook #'rainbow-delimiters-mode)
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package emmet-mode
  :ensure t
  :config
  (eval-after-load 'web-mode
    '(define-key web-mode-map (kbd "TAB") 'emmet-expand-line))
  (add-hook 'css-mode-hook  'emmet-mode)
  (eval-after-load 'css-mode
    '(define-key css-mode-map (kbd "TAB") 'emmet-expand-line)))

(use-package visual-regexp
  :config
  (define-key global-map (kbd "C-c r") 'vr/replace)
  (define-key global-map (kbd "C-c q") 'vr/query-replace)
  (define-key global-map (kbd "C-c m") 'vr/mc-mark))


; (use-package go-mode
;   :ensure f
;   :no-require t
;   :mode "\\.go\\'"
;   :init
;   (ensure-package-installed 'go-mode))

;; (ensure-package-installed 'iedit 'magit)


(provide '_code)

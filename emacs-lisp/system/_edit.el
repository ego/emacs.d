;; 

(use-package edit-server
  :if (system-is-linux)
  :init
  (message "edit-server %s" (system-is-linux))
  (add-hook 'after-init-hook 'server-start t)
  (add-hook 'after-init-hook 'edit-server-start t))

;; (use-package whitespace
;;   :bind (("C-c T w" . whitespace-mode))
;;   :init
;;   (dolist (hook '(prog-mode-hook text-mode-hook
;;                                  conf-mode-hook))
;;     (add-hook hook #'whitespace-mode))
;;   :config (setq whitespace-line-column nil)
;;   :diminish whitespace-mode)

(use-package saveplace
  :doc "https://www.emacswiki.org/emacs/SavePlace"
  :tag "save place"
  :init (setq save-place-file user-saveplace)
  :config 
                                        ; (setq-default save-place t)
  (save-place-mode 1))

(defun emacs-ide-wrap-with (s)
  "Create a wrapper function for smartparens using S."
  `(lambda (&optional arg)
     (interactive "P")
     (sp-wrap-with-pair ,s)))

(use-package paredit
  :doc "https://www.emacswiki.org/emacs/ParEdit
  http://emacsrocks.com/e14.html"
  :tag "programming"
  :config
  (add-hook 'lisp-mode-hook 'paredit-mode)
  (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
  (add-hook 'clojure-mode-hook 'paredit-mode)
  (add-hook 'cider-repl-mode-hook 'paredit-mode)

  (define-key prog-mode-map (kbd "M-(") (emacs-ide-wrap-with "("))
  ;; FIXME: pick terminal friendly binding
  ;; (define-key prog-mode-map (kbd "M-[") (emacs-ide-wrap-with "["))
  (define-key prog-mode-map (kbd "M-\"") (emacs-ide-wrap-with "\"")))

(use-package undo-tree
  :doc "https://www.emacswiki.org/emacs/UndoTree"
  :tag "editing undo"
  :hot-key "
   C-_  C-/  (`undo-tree-undo') Undo changes.
   M-_  C-?  (`undo-tree-redo') Redo changes."
  :diminish undo-tree-mode
  :init
  (setq undo-tree-visualizer-timestamps t
        undo-tree-visualizer-diff t)
  :config
  (global-undo-tree-mode 1))

(use-package volatile-highlights
  :doc "https://github.com/k-talo/volatile-highlights.el"
  :tag "programming"
  :diminish volatile-highlights-mode
  :config
  (volatile-highlights-mode t)

  ;; Supporting undo-tree.
  (defun vhl/ext/undo-tree/load ()
    (vhl/define-extension 'undo-tree 'undo-tree-yank 'undo-tree-move)
    (vhl/install-extension 'undo-tree))

  (cond
   ((featurep 'undo-tree)
    (vhl/ext/undo-tree/load))
   (t
    (eval-after-load "undo-tree" '(vhl/ext/undo-tree/load)))))

;; note - this should be after volatile-highlights is required
;; add the ability to cut the current line, without marking it
(use-package rect
  :doc ""
  :tag "edit"
  :ensure f
  :config
  (defadvice kill-region (before smart-cut activate compile)
    "When called interactively with no active region, kill a single line instead."
    (interactive
     (if mark-active (list (region-beginning) (region-end) rectangle-mark-mode)
       (list (line-beginning-position)
             (line-beginning-position 2))))))


(provide '_edit)

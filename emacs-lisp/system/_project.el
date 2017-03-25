;;

(use-package projectile
  :doc "projectile is a project management mode
  https://github.com/bbatsov/projectile
  http://projectile.readthedocs.io/en/latest/usage/"
  :tag "project management"
  :diminish projectile-mode
  :init
  (setq projectile-cache-file user-projectile
        projectile-known-projects-file user-projectile-known-projects-file)
  (projectile-global-mode t))

(use-package perspective
  :doc "A minor mode that provides the ability to manage different workspaces
  https://github.com/bbatsov/persp-projectile
  https://github.com/nex3/perspective-el"
  :init
  (persp-mode)
  (use-package persp-projectile
    :demand t
    :init
    (require 'persp-projectile)
    (bind-key "C-c C-p s" 'projectile-persp-switch-project projectile-mode-map)))

(use-package recentf
  :doc "https://www.emacswiki.org/emacs/RecentFiles"
  :tag "recent files"
  :hot-key "C-x C-r"
  :init
  (setq recentf-save-file user-recentf
        recentf-max-menu-items 100
        recentf-auto-cleanup 'never)

  :config
  (recentf-mode +1)

  (defun recentf-ido-find-file ()
    "Find a recent file using Ido."
    (interactive)
    (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
      (when file
        (find-file file))))
    (global-set-key (kbd "C-x C-r") 'recentf-ido-find-file)
    (global-set-key (kbd "C-x C-c") 'recentf-open-files)    ;; rebind save and exit!
  )

;; Плохо работает с saveplace при клике мышкой!!
; (use-package dashboard
;   :doc "https://github.com/rakanalh/emacs-dashboard"
;   :tag "project dashboard"
;   :diminish dashboard-mode
;   :config
;     (dashboard-setup-startup-hook)

;     (defun dashboard-insert-custom (list-size)
;       (insert "Next my item"))

;     (add-to-list 'dashboard-item-generators  '(custom . dashboard-insert-custom))
;     (add-to-list 'dashboard-items '(custom) t))


(provide '_project)

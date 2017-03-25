;; System vars and boot

(defvar emacs-lisp
  (expand-file-name "emacs-lisp" emacs-root-dir)
  "Lisp code")

(defvar emacs-system
  (expand-file-name "system" emacs-lisp)
  "System")

(defvar emacs-vendor 
  (expand-file-name "vendor" emacs-lisp)
  "Vendor libs, packages that are not available in ELPA or MELPA.")

(defvar emacs-major-mode
  (expand-file-name "major_mode" emacs-lisp)
  "User packages dir")

(defvar emacs-minor-mode
  (expand-file-name "minor_mode" emacs-lisp)
  "User packages dir")

;; create user dir
(let ((user-name-resources (expand-file-name (concat "resources/" (user-login-name)) emacs-root-dir)))
  (when (not (file-exists-p user-name-resources)) 
    (make-directory user-name-resources)))

(defvar emacs-resources 
  (expand-file-name (concat "resources/" (user-login-name)) emacs-root-dir)
  "User files")

(defvar emacs-site-lisp 
  (expand-file-name "site-lisp" emacs-root-dir)
  "This folder stores all packages that are available in ELPA or MELPA.")

(defvar emacs-themes 
  (expand-file-name "themes" emacs-lisp)
  "Themes")

(defvar user-backups 
  (expand-file-name "backups" emacs-resources)
  "This folder stores all the automatically generated files.")

(defvar user-smex-items
  (expand-file-name "smex/smex-items" emacs-resources)
  "This folder stores all the automatically generated files.")

(defvar user-auto-save
  (expand-file-name "auto-save/" emacs-resources)
  "auto-save")

(defvar user-ido
  (expand-file-name "ido/ido.last" emacs-resources)
  "user-ido")

(defvar user-saveplace 
  (expand-file-name "saveplace/saveplace" emacs-resources)
  "saveplace")

(defvar user-savehist 
  (expand-file-name "savehist/history" emacs-resources)
  "savehist")

(defvar user-recentf 
  (expand-file-name "recentf/recentf" emacs-resources)
  "recentf")

(defvar user-desktop-dirname
  (expand-file-name "desktop/" emacs-resources)
  "desktop")

(defvar user-desktop-file-name
  (expand-file-name "desktop/.emacs.desktop" emacs-resources)
  "desktop")

(defvar user-tramp 
  (expand-file-name "tramp" emacs-resources)
  "tramp")

(defvar user-bookmark 
  (expand-file-name "bookmark/bookmark" emacs-resources)
  "bookmark")

(defvar user-projectile 
  (expand-file-name "projectile/projectile.cache" emacs-resources)
  "projectile")

(defvar user-projectile-known-projects-file 
  (expand-file-name "projectile/projectile-bookmarks.eld" emacs-resources)
  "projectile-known-projects-file")


;; Load core packages ====================


(defun add-to-load-path (dir) 
  (add-to-list 'load-path dir))


;; load paths
(mapc 'add-to-load-path
      `(
        ,emacs-system
        ,emacs-vendor
        ,emacs-major-mode
        ,emacs-minor-mode
        ,emacs-themes
        ))


;; order metter
(require '_setq)
(require '_packages)
(require '_use-package)
(require '_ui)
(require '_core)
(require '_code)
(require '_edit)
(require '_func)
(require '_menu)
(require '_window)
(require '_key-chord)
(require '_utils)

(require '_project)
(require '_hydra)        ;; dependens on _project

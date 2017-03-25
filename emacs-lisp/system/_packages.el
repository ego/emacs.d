;; Install core package, auto-install-mode, add-hook

(require 'cl)
(require 'package)


;; Core packages
(defvar user-packages
  '(use-package
     bind-key
     which-key
     guide-key
     key-chord
     free-keys
     keyfreq
     desktop

     ;; modes
     god-mode
     org

     undo-tree
     recentf

     ace-window
     hydra

     zenburn-theme
     
     crm-custom
     flx-ido
     ido-ubiquitous
     ido-clever-match
     ido-yes-or-no
     ido-grid-mode
     ido-at-point
     ido-describe-bindings
     ido-complete-space-or-hyphen
     idomenu
     imenu+
     imenu-anywhere
     ;; ido-vertical-mode

     ggtags
     bookmark+ 
     bm

     projectile
     perspective
     persp-projectile
     saveplace
     dashboard
     
     doremi
     doremi-frm
     doremi-cmd
     doremi-mac
     facemenu+
     eyedropper
     highlight
     frame-cmds
     hexrgb
     ring
     zoom-frm
     help+
     help-fns+
     thumb-frm
     cmds-menu
     fit-frame
     second-sel
     menu-bar+

     magit

     volatile-highlights
     anzu
     goto-last-change
     diff-hl
     rainbow-mode

     visual-regexp
     emmet-mode

     company
     company-flx
     company-tern
     company-edbi
     company-web

     paredit
     highlight-parentheses
     rainbow-delimiters
     aggressive-indent)
  "The list of user packages.")


(defun user-install-packages ()
  "Install all packages listed in `user-packages'."
  (unless (user-packages-installed-p)
    (package-refresh-contents)
    (user-require-packages user-packages)))

(defun user-packages-installed-p ()
  "Check if all packages in `user-packages' are installed."
  (every #'package-installed-p user-packages))

(defun user-require-package (package)
  "Install PACKAGE unless already installed."
  (unless (memq package user-packages)
    (add-to-list 'user-packages package))
  (unless (package-installed-p package)
    (package-install package)))

(defun user-require-packages (packages)
  "Ensure PACKAGES are installed. Missing packages are installed automatically."
  (mapc #'user-require-package packages))

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))


;; Added repo ==========================

(add-to-list 'package-archives 
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)

(add-to-list 'package-archives 
             '("melpa" . "https://melpa.org/packages/") t)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)


(add-to-list 'package-pinned-packages '(cider . "melpa-stable") t)


;; Install core packages
(package-initialize)
(user-install-packages)


;; auto-mode-alist =======================

(defmacro system-auto-install (extension package mode)
  "When file with EXTENSION is opened triggers auto-install of PACKAGE.
PACKAGE is installed only if not already present.  The file is opened in MODE."
  `(add-to-list 'auto-mode-alist
                `(,extension . (lambda ()
                                 (unless (package-installed-p ',package)
                                   (package-install ',package))
                                 (,mode)))))


(defvar auto-install-mode
  '(("\\(\\.\\(clj\\|dtm\\|edn\\)\\'\\|\\(?:build\\|profile\\)\\.boot\\'\\|\\.boot\\'\\)" clojure-mode clojure-mode)
    ("\\.clj\\'"            clojure-mode clojure-mode)
    ("\\(\\.cljs\\)"        clojure-mode clojure-mode)
    ("\\(\\.cljc\\)"        clojure-mode clojure-mode)
    ("\\(\\.cljx\\)"        clojure-mode clojure-mode)
    ("\\.cmake\\'"          cmake-mode cmake-mode)
    ("CMakeLists\\.txt\\'"  cmake-mode cmake-mode)
    ("\\.coffee\\'"         coffee-mode coffee-mode)
    ("\\.css\\'"            css-mode css-mode)
    ("\\.csv\\'"            csv-mode csv-mode)
    ("Cask"                 cask-mode cask-mode)
    ("\\.d\\'"              d-mode d-mode)
    ("\\.dart\\'"           dart-mode dart-mode)
    ("\\.elm\\'"            elm-mode elm-mode)
    ("\\.ex\\'"             elixir-mode elixir-mode)
    ("\\.exs\\'"            elixir-mode elixir-mode)
    ("\\.elixir\\'"         elixir-mode elixir-mode)
    ("\\.erl\\'"            erlang erlang-mode)
    ("\\.feature\\'"        feature-mode feature-mode)
    ("\\.go\\'"             go-mode go-mode)
    ("\\.groovy\\'"         groovy-mode groovy-mode)
    ("\\.haml\\'"           haml-mode haml-mode)
    ("\\.hs\\'"             haskell-mode haskell-mode)
    ("\\(\\.[gh]s\\'\\|\\.hsc\\'\\)" haskell-mode haskell-mode)
    ("\\.json\\'"           json-mode json-mode)
    ("\\.kt\\'"             kotlin-mode kotlin-mode)
    ("\\.kv\\'"             kivy-mode kivy-mode)
    ("\\.latex\\'"          auctex LaTeX-mode)
    ("\\.less\\'"           less-css-mode less-css-mode)
    ("\\.lua\\'"            lua-mode lua-mode)
    ("\\.markdown\\'"       markdown-mode markdown-mode)
    ("\\.md\\'"             markdown-mode markdown-mode)
    ("\\.ml\\'"             tuareg tuareg-mode)
    ("\\.pp\\'"             puppet-mode puppet-mode)
    ("\\.php\\'"            php-mode php-mode)
    ("\\.proto\\'"          protobuf-mode protobuf-mode)
    ("\\.pyd\\'"            cython-mode cython-mode)
    ("\\.pyi\\'"            cython-mode cython-mode)
    ("\\.pyx\\'"            cython-mode cython-mode)
    ("PKGBUILD\\'"          pkgbuild-mode pkgbuild-mode)
    ("\\.rs\\'"             rust-mode rust-mode)
    ("\\.sass\\'"           sass-mode sass-mode)
    ("\\.scala\\'"          scala-mode scala-mode)
    ("\\.scss\\'"           scss-mode scss-mode)
    ("\\.slim\\'"           slim-mode slim-mode)
    ("\\.styl\\'"           stylus-mode stylus-mode)
    ("\\.swift\\'"          swift-mode swift-mode)
    ("\\.textile\\'"        textile-mode textile-mode)
    ("\\.thrift\\'"         thrift thrift-mode)
    ("\\.yml\\'"            yaml-mode yaml-mode)
    ("\\.yaml\\'"           yaml-mode yaml-mode)
    ("Dockerfile\\'"        dockerfile-mode dockerfile-mode)))


;; build auto-install mappings
(mapc
 (lambda (entry)
   (let ((extension (car entry))
         (package (cadr entry))
         (mode (cadr (cdr entry))))
     (unless (package-installed-p package)
       (system-auto-install extension package mode))))
 auto-install-mode)


;; markdown-mode
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; pkgbuild-mode
(when (package-installed-p 'pkgbuild-mode)
  (add-to-list 'auto-mode-alist '("PKGBUILD\\'" . pkgbuild-mode)))


;; add-hook ==========================================
;; hooks for autoload custom libs/files for some mode
(add-hook 'markdown-mode-hook 'my-markdown-mode)
(add-hook 'python-mode-hook 'my-python-mode)
(add-hook 'clojure-mode-hook 'my-clojure-mode)

;;;###autoload
(autoload 'my-markdown-mode (expand-file-name (concat emacs-major-mode "/_markdown-mode")) 
  "markdown-mode autoload hook" t)
(autoload 'my-python-mode (expand-file-name (concat emacs-major-mode "/_python-mode")) 
  "python-mode autoload hook" t)
(autoload 'my-clojure-mode (expand-file-name (concat emacs-major-mode "/_clojure-mode")) 
  "clojure-mode autoload hook" t)



(provide '_packages)

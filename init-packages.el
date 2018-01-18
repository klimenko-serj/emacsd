(require 'package)

(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))

(add-to-list 'package-archives
             '("melpa-stable" . "http://melpa-stable.milkbox.net/packages/") t)

(add-to-list 'load-path "~/.emacs.d/site-lisp/")


(setq package-list
      '(
	exec-path-from-shell

	gruvbox-theme
	dashboard

	evil
	evil-leader
	evil-visualstar

	avy

	projectile

	helm
	helm-ag
	helm-projectile

	which-key

	magit
	evil-magit

	company

	neotree

	yasnippet
	clojure-snippets

	;; lisp
	evil-cleverparens
	highlight-parentheses

	;; clojre
	clojure-mode
	clj-refactor
	cider

	;; golang
	go-mode
	go-eldoc

	))

; activate all the packages
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
  (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-refresh-contents)
    (package-install package)))

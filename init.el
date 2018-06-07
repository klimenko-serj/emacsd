(when window-system
  (progn
    (setq initial-frame-alist '((width . 160) (height . 58)))
    (setq default-frame-alist '((width . 160) (height . 58)))
    (tool-bar-mode -1)
    (scroll-bar-mode -1)
    ))

(menu-bar-mode -1)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)


(setq make-backup-files nil)

(recentf-mode 1)
(setq recentf-max-saved-items 1024)
(setq-default recent-save-file "~/.emacs.d/recentf")
(save-place-mode 1)

(load "~/.emacs.d/init-packages")

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
  (exec-path-from-shell-copy-env "GOPATH"))

(load-theme 'gruvbox-dark-soft t)
(set-face-attribute 'default nil :font "Monaco-14")
;; (when (window-system)
;;   (set-frame-font "Fira Code")
;;   (set-face-attribute 'default (selected-frame) :height 140))
;; (let ((alist '((33 . ".\\(?:\\(?:==\\|!!\\)\\|[!=]\\)")
;; 	       (35 . ".\\(?:###\\|##\\|_(\\|[#(?[_{]\\)")
;; 	       (36 . ".\\(?:>\\)")
;; 	       (37 . ".\\(?:\\(?:%%\\)\\|%\\)")
;; 	       (38 . ".\\(?:\\(?:&&\\)\\|&\\)")
;; 	       (42 . ".\\(?:\\(?:\\*\\*/\\)\\|\\(?:\\*[*/]\\)\\|[*/>]\\)")
;; 	       (43 . ".\\(?:\\(?:\\+\\+\\)\\|[+>]\\)")
;; 	       (45 . ".\\(?:\\(?:-[>-]\\|<<\\|>>\\)\\|[<>}~-]\\)")
;; 	       (46 . ".\\(?:\\(?:\\.[.<]\\)\\|[.=-]\\)")
;; 	       (47 . ".\\(?:\\(?:\\*\\*\\|//\\|==\\)\\|[*/=>]\\)")
;; 	       (48 . ".\\(?:x[a-zA-Z]\\)")
;; 	       (58 . ".\\(?:::\\|[:=]\\)")
;; 	       (59 . ".\\(?:;;\\|;\\)")
;; 	       (60 . ".\\(?:\\(?:!--\\)\\|\\(?:~~\\|->\\|\\$>\\|\\*>\\|\\+>\\|--\\|<[<=-]\\|=[<=>]\\||>\\)\\|[*$+~/<=>|-]\\)")
;; 	       (61 . ".\\(?:\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\)\\|[<=>~]\\)")
;; 	       (62 . ".\\(?:\\(?:=>\\|>[=>-]\\)\\|[=>-]\\)")
;; 	       (63 . ".\\(?:\\(\\?\\?\\)\\|[:=?]\\)")
;; 	       (91 . ".\\(?:]\\)")
;; 	       (92 . ".\\(?:\\(?:\\\\\\\\\\)\\|\\\\\\)")
;; 	       (94 . ".\\(?:=\\)")
;; 	       (119 . ".\\(?:ww\\)")
;; 	       (123 . ".\\(?:-\\)")
;; 	       (124 . ".\\(?:\\(?:|[=|]\\)\\|[=>|]\\)")
;; 	       (126 . ".\\(?:~>\\|~~\\|[>=@~-]\\)")
;; 	       )
;; 	     ))
;;   (dolist (char-regexp alist)
;;     (set-char-table-range composition-function-table (car char-regexp)
;; 			  `([,(cdr char-regexp) 0 font-shape-gstring]))))

;; (add-hook 'helm-major-mode-hook
;; 	  (lambda ()
;; 	    (setq auto-composition-mode nil)))


;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1) ((control) . nil))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(setq scroll-conservatively 100000)
(setq scroll-margin 3)
(setq  redisplay-dont-pause t ;; don't pause display on input
       ;; Always redraw immediately when scrolling,
       ;; more responsive and doesn't hang!
       fast-but-imprecise-scrolling nil
       jit-lock-defer-time 0)


(require 'evil)
(evil-mode 1)
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("orange" box))
(setq evil-visual-state-cursor '("brown" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
(setq evil-move-cursor-back nil)

(global-evil-visualstar-mode)
(setq evil-visualstar/persistent t)

(require 'helm)

(require 'projectile)
(projectile-global-mode)

(require 'helm-projectile)
(helm-projectile-on)

(require 'evil-leader)
(global-evil-leader-mode)

(require 'evil-magit)

(global-company-mode)
(setq company-idle-delay 0.2)
(setq company-selection-wrap-around t)
(define-key company-active-map [tab] 'company-complete)
(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "C-k") 'company-select-previous)

;; yasnippet
(require 'yasnippet)
(require 'clojure-snippets)
(yas-global-mode 1)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
(yas-load-directory "~/.emacs.d/snippets")
(setq yas-wrap-around-region t)
;; evil evil-insert-snippet
(add-hook 'yas-before-expand-snippet-hook
		  #'(lambda()
			  (when (evil-visual-state-p)
				(let ((p (point))
					  (m (mark)))
				  (evil-insert-state)
				  (goto-char p)
				  (set-mark m)))))

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-items '((projects . 5)
			(recents  . 5)
                        (bookmarks . 5)
                        (agenda . 5)
                        (registers . 5)))

(add-hook 'prog-mode-hook 'linum-mode)

(defun kill-other-buffers ()
    "Kill all other buffers."
    (interactive)
    (mapc 'kill-buffer
          (delq (current-buffer)
                (remove-if-not 'buffer-file-name (buffer-list)))))

(defun close-all ()
  "Close all buffers and windows"
  (interactive)
  (delete-other-windows)
  (switch-to-buffer "*dashboard*")
  (kill-other-buffers))

;; keybindings

(global-set-key (kbd "M-x") 'helm-M-x)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "<SPC>" 'helm-M-x
  "b" 'helm-mini
  "ff" 'helm-find-files
  "fr" 'helm-recentf
  "fs" 'save-buffer
  "y" 'helm-show-kill-ring
  "pf" 'helm-projectile
  "ps" 'helm-projectile-ag
  "P" 'helm-projectile-switch-project
  "pq" 'projectile-kill-buffers

  "j" 'helm-semantic-or-imenu
  "gs" 'magit-status
  "s" 'avy-goto-char
  "df" 'helm-etags-select

  "wo" 'delete-other-windows
  "wd" 'delete-window
  "wh" 'evil-window-left
  "wl" 'evil-window-right
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wv" 'evil-window-vsplit
  "ws" 'evil-window-split

  "qq" 'save-buffers-kill-emacs
  "qa" 'close-all
  "qp" 'projectile-kill-buffers
  "qb" 'kill-buffer
  "qob" 'kill-other-buffers

  "t" 'neotree-toggle
  "cl" 'comment-line
  "is" 'yas-insert-snippet
  )


(setq projectile-switch-project-action 'neotree-projectile-action)
(add-hook 'neotree-mode-hook
	  (lambda ()
	    (define-key evil-normal-state-local-map (kbd "q") 'neotree-hide)
	    (define-key evil-normal-state-local-map (kbd "I") 'neotree-hidden-file-toggle)
	    (define-key evil-normal-state-local-map (kbd "z") 'neotree-stretch-toggle)
	    (define-key evil-normal-state-local-map (kbd "R") 'neotree-refresh)
	    (define-key evil-normal-state-local-map (kbd "m") 'neotree-rename-node)
	    (define-key evil-normal-state-local-map (kbd "c") 'neotree-create-node)
	    (define-key evil-normal-state-local-map (kbd "d") 'neotree-delete-node)

	    (define-key evil-normal-state-local-map (kbd "s") 'neotree-enter-vertical-split)
	    (define-key evil-normal-state-local-map (kbd "S") 'neotree-enter-horizontal-split)

	    (define-key evil-normal-state-local-map (kbd "o") 'neotree-enter)))


;; clojure
(defun cider-switch-ns-and-goto-repl ()
  (interactive)
  (call-interactively 'cider-repl-set-ns)
  (cider-switch-to-repl-buffer))

(defun find-tag-without-ns (next-p)
  (interactive "P")
  (find-tag (first (last (split-string (symbol-name (symbol-at-point)) "/")))
            next-p))

(defun clj-find ()
  (interactive)
  (condition-case nil
      (cider-find-dwim (symbol-name (symbol-at-point)))
    (error (call-interactively 'find-tag-without-ns))))

(defun lisp-editing-keybindings ()
  (show-paren-mode)
  (highlight-parentheses-mode)
  (paredit-mode)
  (evil-cleverparens-mode)

  (local-set-key (kbd "M-(") 'paredit-wrap-round)
  (local-set-key (kbd "M-[") 'paredit-wrap-square)
  (local-set-key (kbd "M-{") 'paredit-wrap-curly))

(defun clojure-editing-keybindings ()
  (lisp-editing-keybindings)
  (cljr-add-keybindings-with-prefix "s-r")
  (evil-leader/set-key
    "r"  'cljr-helm
    "eb" 'cider-eval-buffer
    "ef" 'cider-eval-defun-at-point
    "es" 'cider-eval-last-sexp
    "cj" 'cider-jack-in
    "cc" 'cider-connect
    "cn" 'cider-switch-ns-and-goto-repl
    "dd" 'clj-find
    ))

(defun clj-tags-regen ()
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (start-process-shell-command
     "clj-ctags" nil "ctags -Re -f \"TAGS\" src")))

(defun clojure-install-env ()
  (setq tags-revert-without-query 1)
  (add-hook 'after-save-hook 'clj-tags-regen)

  (clj-refactor-mode 1)
  (clojure-editing-keybindings))

(add-hook 'lisp-mode-hook #'lisp-editing-keybindings)
(add-hook 'clojure-mode-hook #'clojure-install-env)
(add-hook 'emacs-lisp-mode-hook #'lisp-editing-keybindings)


;; golang
(setq go-path (concat (getenv "HOME") "/go/"))
(add-to-list 'exec-path (concat go-path "bin/"))
(add-to-list 'load-path (concat go-path "src/github.com/nsf/gocode/emacs-company"))
(require 'company-go)

(setq gofmt-command "goimports")


(defun my-go-mode-hook ()
  ;; with the gofmt-before-save hook above.
  (add-hook 'before-save-hook 'gofmt-before-save)

  ;; Customize compile command to run go build
  (if (not (string-match "go" compile-command))
      (set (make-local-variable 'compile-command)
           "go build -v && go test -v && go vet"))

  (evil-leader/set-key
    "cc" 'compile
    "cf" 'gofmt
    "dd" 'godef-jump
    "dD" 'godef-describe
    )
 (set (make-local-variable 'company-backends) '(company-go)))

(add-hook 'go-mode-hook 'my-go-mode-hook)
(add-hook 'go-mode-hook 'go-eldoc-setup)
(add-hook 'go-mode-hook 'company-mode)

(require 'which-key)
(which-key-mode)


(require 'whitespace)
;; (setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face empty tabs trailing)) ;; lines-tail for tailing lines
(add-hook 'prog-mode-hook 'whitespace-mode)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq-default mode-line-format
	       (list ""
		     '(:eval evil-mode-line-tag)
		     ;; line and column
		     (propertize "%l" 'face 'font-lock-type-face) ":"
		     (propertize "%c" 'face 'font-lock-type-face)
		     " | "
		     "%+"
		     '(:eval (propertize "%b " 'face 'font-lock-builtin-face
					 'help-echo (buffer-file-name)))


		     ;; relative position, size of file
		     "["
		     (propertize "%p" 'face 'font-lock-constant-face) ;; % above top
		     "/"
		     (propertize "%I" 'face 'font-lock-constant-face) ;; size
		     "]"

		     '(vc-mode vc-mode)
		     ;; the current major mode for the buffer.
		     " | "
		     '(:eval (propertize "%m" 'face 'font-lock-string-face
					 'help-echo buffer-file-coding-system))
		     " %-"

		     ))

(setq auto-revert-check-vc-info t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (avy evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-keyword-face ((t (:foreground "salmon")))))

(when window-system
  (progn
    ;(set-frame-size (selected-frame) 160 58)
    (setq initial-frame-alist '((width . 160) (height . 58)))
    (setq default-frame-alist '((width . 160) (height . 58)))
    ))


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq make-backup-files nil)

(recentf-mode 1)
(setq-default recent-save-file "~/.emacs.d/recentf")

(load "~/.emacs.d/init-packages")

(load-theme 'gruvbox-dark-soft t)

(require 'evil)
(evil-mode 1)
(setq evil-emacs-state-cursor '("red" box))
(setq evil-normal-state-cursor '("orange" box))
(setq evil-visual-state-cursor '("brown" box))
(setq evil-insert-state-cursor '("red" bar))
(setq evil-replace-state-cursor '("red" bar))
(setq evil-operator-state-cursor '("red" hollow))
(setq evil-move-cursor-back nil)

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


(require 'powerline)
(powerline-evil-vim-color-theme)
(display-time-mode t)

(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-items '((recents  . 5)
                        (projects . 5)
                        (bookmarks . 5)
                        (agenda . 5)
                        (registers . 5)))

(require 'fill-column-indicator)
(setq fci-rule-column 100)
(defun on-off-fci-before-company(command)
  (when (string= "show" command)
    (turn-off-fci-mode))
  (when (string= "hide" command)
    (turn-on-fci-mode)))
(advice-add 'company-call-frontends :before #'on-off-fci-before-company)
(add-hook 'prog-mode-hook 'fci-mode)
;; (add-hook 'elisp-mode 'fci-mode)
;; (add-hook 'clojure-mode 'fci-mode)


;; keybindings

(global-set-key (kbd "M-x") 'helm-M-x)

(evil-leader/set-leader "<SPC>")
(evil-leader/set-key
  "<SPC>" 'helm-M-x
  "b" 'helm-mini
  "f" 'helm-find-files
  "y" 'helm-show-kill-ring
  "r" 'helm-recentf
  "pf" 'helm-projectile
  "ps" 'helm-projectile-ag
  "P" 'helm-projectile-switch-project
  "j" 'helm-semantic-or-imenu
  "gs" 'magit-status

  "wo" 'delete-other-windows
  "wd" 'delete-window
  "wh" 'evil-window-left
  "wl" 'evil-window-right
  "wj" 'evil-window-down
  "wk" 'evil-window-up
  "wv" 'evil-window-vsplit
  "ws" 'evil-window-split

  "qq" 'save-buffers-kill-emacs
  "t" 'neotree-toggle
  "cl" 'comment-line
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


(require 'helm-descbinds)
(helm-descbinds-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

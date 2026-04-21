;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq doom-theme 'modus-operandi)

;; Treemacs
(after! treemacs
  (setq treemacs-position 'right
        treemacs-collapse-dirs 3))

;; Calendar holidays (shown in org-agenda via org-agenda-include-diary)
(setq diary-file "~/org/scheduling/diary")

;; Org
(after! org
  (setq org-startup-with-inline-images t
        org-image-actual-width 600)

  (setq org-agenda-files '("~/org/scheduling/tasks.org"
                           "~/org/scheduling/inbox.org"
                           "~/org/scheduling/projects.org"
                           "~/org/scheduling/calendar.org"))
  (setq org-agenda-include-diary t)

  ;; Keywords: action states | terminal states
  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "IN-PROGRESS(i!)" "WAIT(w@/!)" "|" "DONE(d!)" "CANCELLED(c@)")))

  (setq org-todo-keyword-faces
        '(("TODO"        . (:foreground "#a60000" :weight bold))
          ("NEXT"        . (:foreground "#0031a9" :weight bold))
          ("IN-PROGRESS" . (:foreground "#8f0075" :weight bold))
          ("WAIT"        . (:foreground "#7a4f00" :weight bold))
          ("DONE"        . (:foreground "#005f00"))
          ("CANCELLED"   . (:foreground "#505050" :strike-through t))))

(setq org-highest-priority ?A
        org-lowest-priority  ?C
        org-default-priority ?B)
  (setq org-use-fast-todo-selection t)
  (setq org-log-done 'time)
  (setq org-log-into-drawer t)

  (setq org-agenda-span 10 
        org-agenda-start-on-weekday nil)
  (setq org-agenda-sort-notime-is-late t)
  (setq org-agenda-sorting-strategy
        '((agenda priority-down scheduled-up deadline-up)
          (todo   priority-down category-up)
          (tags   priority-down category-up)))

  ;; Custom agenda views
  (setq org-agenda-custom-commands
        '(("d" "Today" agenda ""
           ((org-agenda-span 1)
            (org-agenda-start-on-weekday nil)))
          ("n" "Next actions" todo "NEXT"
           ((org-agenda-sorting-strategy '(priority-down))))
          ("w" "Waiting" todo "WAIT")
          ("r" "Weekly review"
           ((agenda "" ((org-agenda-span 7)))
            (todo "NEXT")
            (todo "WAIT")))))

  (setq org-capture-templates
        '(("i" "Inbox" entry
           (file "~/org/scheduling/inbox.org")
           "* %?\n")
          ("t" "Todo" entry
           (file+headline "~/org/scheduling/tasks.org" "Tasks")
           "* TODO %?\n  SCHEDULED: %t\n")
          ("n" "Next action" entry
           (file+headline "~/org/scheduling/tasks.org" "Tasks")
           "* NEXT [#B] %?\n")
)))

(map! :leader
      :desc "Open inbox.org" "o i"
      (cmd! (find-file "~/org/scheduling/inbox.org")))

;; Use LSP for Java formatting (via jdtls)
(after! apheleia
  (setf (alist-get 'java-mode apheleia-mode-alist) 'lsp))

;; Java / lsp-java
(after! lsp-java
  (setq lsp-java-vmargs
        '("-noverify"
          "-Xmx1G"
          "-XX:+UseG1GC"
          "-XX:+UseStringDeduplication"))
  ;; Auto-organize imports on save
  (setq lsp-java-save-actions-organize-imports t))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)
(setq-default tab-width 4)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


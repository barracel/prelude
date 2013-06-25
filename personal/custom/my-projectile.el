; projectile settings
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)

;(setq my-projectile-project-root "/home/oso/dev/workspace/jobboard")

;; Custom projectile project root. So I can force it
(defun projectile-project-root ()
  (if (boundp 'my-projectile-project-root)
      my-projectile-project-root

; projectile settings
(setq projectile-show-paths-function 'projectile-hashify-with-relative-paths)

;(setq my-projectile-project-root "/home/oso/dev/workspace/jobboard")
;(setq my-projectile-project-root "/home/ofernandez/workspace/jobboard/")

(defadvice projectile-project-root (around my-force-projectile-project-root ())
  (if (boundp 'my-projectile-project-root)
      (setq ad-return-value my-projectile-project-root)
    ad-do-it))

(ad-activate 'projectile-project-root)
; still not working so deactivate it
(ad-deactivate 'projectile-project-root )

for dir in /lib /lib64 /usr/lib /usr/lib64 /usr/X11R6/lib /usr/X11R6/lib64 /usr/qt/*/lib /usr/qt/*/lib64 /usr/kde/*/lib /usr/kde/*/lib64; do
	if [ -L "${dir}" ]; then
		ewarn "${dir} is a symlink"
		#exit 1
	fi
done

if [ -z "${IWANTTOTRASHMYSYSTEM}" ]; then
	eerror "The amd64 2005.0/no-symlinks profile is still in active development"
	eerror "and not yet ready for user testing.  An announcement will be made"
	eerror "on gentoo-amd64@gentoo.org once we are ready for testers."
	exit 1
fi

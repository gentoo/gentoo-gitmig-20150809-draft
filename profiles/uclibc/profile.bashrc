# Copyright 2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/profiles/uclibc/profile.bashrc,v 1.5 2005/04/18 19:34:43 solar Exp $

#
# FEATURES="distclean"
# This feature removes unneeded SRC_URI distfiles in the postinst ebuild phase.
# This is useful with ramfs/tmpfs and smaller media such as USB sticks.
#


eecho() {
	[ "$NOCOLOR" = "false" ] && echo -ne '\e[1;34m>\e[1;36m>\e[1;35m>\e[0m ' || echo -n ">>> "
	echo "$*"
}

package_clean_distdir() {
	local a x
	for a in ${FEATURES} ; do 
		if [ "$a" = "distclean" ]; then
			for x in ${SRC_URI}; do
			x=$(basename $x)
				if [[ -w $DISTDIR/$x ]]; then
					size="$(ls -lh ${DISTDIR}/${x} | awk '{print $5}')"
					eecho "Auto removing ${x} to save ${size}"
					rm ${DISTDIR}/${x}
				fi
			done
		fi
	done
}

if [[ $EBUILD_PHASE != "" ]]; then
	PATH="/sbin:/usr/sbin:/usr/lib/portage/bin:/bin:/usr/bin:${ROOTPATH}"
	case "${EBUILD_PHASE}" in
		preinst)
			[[ $ROOT != "" ]] && [[ $ROOT != "/" ]] \
				&& [ -r /etc/portage/root_install_mask ] \
				&& INSTALL_MASK="${INSTALL_MASK} $(< /etc/portage/root_install_mask)"
			;;
		postinst)
			package_clean_distdir
		;;
		# try to stay quiet in depend.
		depend) : ;;
		prerm|postrm|clean) : ;;
		setup|unpack|postinst|compile|*) : ;;
	esac
fi

# Example of per package env variables
# Searches and break in the flat text files of
#	pkgname-pkgver-pkgrevision 
#	pkgname-pkgver 
#	pkgname

#for conf in ${PN}-${PV}-${PR} ${PN}-${PV} ${PN}; do
#	if [[ -r /etc/portage/env/$CATEGORY/${conf} ]]; then
#		. /etc/portage/env/$CATEGORY/${conf}
#		break
#	fi
#done

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Brandon Low <lostlogic@lostlogicx.com>
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.12.0.ebuild,v 1.2 2002/04/25 06:56:22 drobbins Exp $

DESCRIPTION="em8300 video decoder card kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net"

DEPEND="virtual/linux-sources"

S="${WORKDIR}/${P}"
SRC_URI="http://prdownloads.sourceforge.net/dxr3/${P/-modules/}.tar.gz"


src_unpack () {

	unpack ${A}
	cd ${WORKDIR}
	mv ${A/.tar.gz/} ${P}

}

src_compile ()  {

	cd ${S}/modules
	sed -e s/PAL/NTSC/g Makefile > makefile
	mv makefile Makefile

	[ "x${KV}" = x ] && die "You need to upgrade your portage."

	#Make the em8300 makefile cooperate with our kernel version
	sed -e s/..shell.uname.-r./${KV}/ Makefile > makefile
	mv makefile Makefile
	make clean all || die

}

src_install () {

	insinto "/usr/src/linux/include/linux"
	doins include/linux/em8300.h

	# The driver goes into the standard modules location
	insinto "/lib/modules/${KV}/kernel/drivers/video"
	doins modules/em8300.o modules/bt865.o modules/adv717x.o
		
	# Docs
	dodoc modules/README-modoptions \
	      modules/README-modules.conf \
	      modules/devfs_symlinks

	insinto /etc/modules.d
	newins ${FILESDIR}/modules.em8300 em8300

}

pkg_postinst() {

	if [ "${ROOT}" = "/" ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
		[ -x /sbin/depmod ]             && /sbin/depmod -a
	fi

	einfo
	einfo "The em8300 kernel modules have been installed into the modules"
	einfo "directory of your currently running kernel.  They haven't been"
	einfo "loaded.  Please read the documentation, and if you would like"
	einfo "to have the modules load at startup, add em8300, bt865, adv717x"
	einfo "to your /etc/modules.autoload they may need module options to "
	einfo "work correctly on your system.  You will also need to add"
	einfo "the contents of /usr/share/doc/em8300-0.12.0/devfs_symlinks"
	einfo "to your devfsd.conf so that the em8300 devices will be linked"
	einfo "correctly."
	einfo 

}

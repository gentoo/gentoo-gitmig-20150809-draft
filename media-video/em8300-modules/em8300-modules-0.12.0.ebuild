# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Brandon Low <lostlogic@lostlogicx.com>
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.12.0.ebuild,v 1.4 2002/05/03 07:13:05 agenkin Exp $

DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net"

DEPEND="virtual/linux-sources"

SRC_URI="http://prdownloads.sourceforge.net/dxr3/${P/-modules/}.tar.gz"
S="${WORKDIR}/${P}"


src_unpack () {

	unpack ${A}
	cd ${WORKDIR}
	mv ${A/.tar.gz/} ${P}

	# Portage should determine the version of the kernel sources
	if [ x"${KV}" = x ]
	then
		eerror ""
		eerror "Could not determine you kernel version."
		eerror "Make sure that you have /usr/src/linux symlink."
		eerror ""
		die
	fi

	cd ${S}/modules
	#Make the em8300 makefile cooperate with our kernel version
	sed 	-e 's/PAL/NTSC/g' \
		-e "s/..shell.uname.-r./${KV}/" \
		Makefile > Makefile.hacked
	mv Makefile.hacked Makefile

}

src_compile ()  {

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

pkg_postinst () {

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
	einfo "You will also need to have the i2c kernel modules compiled for"
	einfo "this to be happy, no need to patch any kernel though just turn"
	einfo "all the i2c stuff in kernel config to M and you'll be fine."
	einfo 

}

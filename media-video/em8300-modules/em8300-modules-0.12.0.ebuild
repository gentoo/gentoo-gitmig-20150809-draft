# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.12.0.ebuild,v 1.16 2004/07/14 21:34:00 agriffis Exp $

S="${WORKDIR}/${P}/modules"
DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="mirror://sourceforge/dxr3/${P/-modules/}.tar.gz"

DEPEND="virtual/linux-sources"
RDEPEND="${DEPEND}
	>=sys-apps/portage-1.9.10"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""


src_unpack () {

	unpack ${A}
	cd ${WORKDIR}
	mv ${A/.tar.gz/} ${P}

	# Portage should determine the version of the kernel sources
	check_KV

	cd ${S}
	#Make the em8300 makefile cooperate with our kernel version
	#and default to NTSC video output, xine and other players
	#should be able to set this at runtime, but NTSC is a better
	#default (I think)
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
	doins ../include/linux/em8300.h

	# The driver goes into the standard modules location
	insinto "/lib/modules/${KV}/kernel/drivers/video"
	doins em8300.o bt865.o adv717x.o

	# Docs
	dodoc README-modoptions \
	      README-modules.conf \
	      devfs_symlinks

	insinto /etc/modules.d
	newins ${FILESDIR}/modules.em8300 em8300

}

pkg_postinst () {

	if [ "${ROOT}" = "/" ]
	then
		[ -x /usr/sbin/update-modules ] && /usr/sbin/update-modules
	fi

	einfo
	einfo "The em8300 kernel modules have been installed into the modules"
	einfo "directory of your currently running kernel.  They haven't been"
	einfo "loaded.  Please read the documentation, and if you would like"
	einfo "to have the modules load at startup, add em8300, bt865, adv717x"
	einfo "to your /etc/modules.autoload they may need module options to "
	einfo "work correctly on your system.  You will also need to add"
	einfo "the contents of /usr/share/doc/${P}/devfs_symlinks.gz"
	einfo "to your devfsd.conf so that the em8300 devices will be linked"
	einfo "correctly."
	einfo
	einfo "You will also need to have the i2c kernel modules compiled for"
	einfo "this to be happy, no need to patch any kernel though just turn"
	einfo "all the i2c stuff in kernel config to M and you'll be fine."
	einfo

}

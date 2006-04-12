# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/em8300-modules/em8300-modules-0.15.3.ebuild,v 1.1 2006/04/12 20:15:06 arj Exp $

inherit eutils linux-info

S="${WORKDIR}/${A/.tar.gz/}/modules"
DESCRIPTION="em8300 (RealMagic Hollywood+/Creative DXR3) video decoder card kernel modules"
HOMEPAGE="http://dxr3.sourceforge.net"
SRC_URI="mirror://sourceforge/dxr3/${P/-modules/}.tar.gz"

DEPEND="virtual/linux-sources"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

src_unpack () {

	unpack ${A}
	cd ${S}
}

src_compile ()  {

	check_KV
	set_arch_to_kernel
	cd ..
	for file in autotools/config.guess configure modules/ldm modules/Makefile modules/INSTALL; do
		sed -i -e 's/uname[[:space:]]*-r/echo ${KV}/' $file
	done
	cd modules
	make || die
	set_arch_to_portage
}

src_install () {

	insinto "/usr/include/linux"
	doins ../include/linux/em8300.h

	check_KV


	# The driver goes into the standard modules location
	insinto "/lib/modules/${KV}/kernel/drivers/video"

	if [ "${KV:0:3}" == "2.6" ]
	then
		doins em8300.ko bt865.ko adv717x.ko
	else
		doins em8300.o bt865.o adv717x.o
	fi

	# Docs
	dodoc README-modoptions \
	      README-modules.conf \
	      devfs_symlinks

	insinto /etc/modules.d
	newins ${FILESDIR}/modules.em8300 em8300

	insinto /etc/udev/rules.d
	newins em8300-udev.rules 15-em8300.rules
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

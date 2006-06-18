# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/legousbtower/legousbtower-0.5.4.ebuild,v 1.1 2006/06/18 13:59:30 pylon Exp $

inherit linux-mod

DESCRIPTION="The lego mindstorms usb tower headers and/or modules"
SRC_URI="mirror://sourceforge/legousb/${P}.tar.gz"
HOMEPAGE="http://legousb.sourceforge.net/"

SLOT="0"
LICENSE="MPL-1.0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="virtual/libc"

src_compile()
{
	if [ ${KV_MINOR} -eq 4 ] ; then
		econf || die "Configuration failed"
		emake || die "Compilation failed"
	fi
}

src_install() {
	if [ ${KV_MINOR} -eq 4 ] ; then
		einstall || die "Make Install Failed"
	else
		insinto /usr/include/LegoUSB
		doins include/legousbtower.h
		insinto /etc/udev/rules.d
		doins ${FILESDIR}/20-lego.rules
	fi
	dodoc README
}

pkg_postinst() {
	if [ ${KV_MINOR} -eq 4 ] ; then
		einfo "You are using the 2.4 kernel series."
		einfo "These are unsupported."
	else
		einfo "You are using the 2.6 kernel series."
		einfo "This package only provides the header file."
		einfo "You need to enable the lego usb tower option in the kernel."
	fi
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/gxmessage/gxmessage-2.0.11.ebuild,v 1.3 2004/09/02 22:49:40 pvdabeel Exp $

IUSE=""

DESCRIPTION="A GTK2 based xmessage clone"
HOMEPAGE="http://homepages.ihug.co.nz/~trmusson/programs.html#gxmessage"
SRC_URI="http://homepages.ihug.co.nz/~trmusson/stuff/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc"

DEPEND=">=x11-libs/gtk+-2.2"
RDEPEND="virtual/x11"

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ABOUT-NLS COPYING ChangeLog README INSTALL

	docinto examples
	dodoc examples/gxaddress examples/gxdialup examples/gxdict examples/gxman \
	examples/gxview
}

pkg_postinst() {
	echo
	einfo "A few example usage scripts have been installed into"
	einfo "/usr/share/doc/${PF}/examples."
	echo
}

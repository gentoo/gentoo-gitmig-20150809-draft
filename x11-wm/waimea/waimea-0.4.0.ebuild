# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.4.0.ebuild,v 1.11 2004/07/15 01:16:51 agriffis Exp $

DESCRIPTION="Window manager based on BlackBox"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
HOMEPAGE="http://www.waimea.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/x11
	media-libs/imlib2
	virtual/xft"
PROVIDE="virtual/blackbox"

src_compile() {
	econf \
		--enable-shape \
		--enable-xinerama \
		--enable-render \
		--enable-randr \
		--enable-xft \
		--enable-pixmap \
		|| die
	emake || die
}

src_install() {
	einstall sysconfdir=${D}/etc/X11/waimea || die

	dodoc ChangeLog AUTHORS COPYING INSTALL README TODO NEWS

	exeinto /etc/X11/Sessions
	echo "/usr/bin/waimea" > waimea
	doexe waimea
}

pkg_postinst() {
	einfo "Please read the README in /usr/share/doc/${PF}"
	einfo "for info on setting up and configuring waimea"
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.4.0.ebuild,v 1.8 2003/09/04 07:36:40 msterret Exp $

DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://www.waimea.org/files/stable/source/${P}.tar.bz2"
HOMEPAGE="http://www.waimea.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"

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

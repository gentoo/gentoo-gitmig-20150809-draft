# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.4.0-r1.ebuild,v 1.8 2003/12/17 16:39:58 usata Exp $

inherit eutils

DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://www.waimea.org/files/stable/source/${P}.tar.bz2
	cjk? ( http://poincare.ikezoe.net/patch/${P}-japanese.patch )"
HOMEPAGE="http://www.waimea.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc"
IUSE="truetype xinerama cjk"

DEPEND="virtual/x11
	media-libs/imlib2
	virtual/xft"

PROVIDE="virtual/blackbox"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	use cjk && epatch ${DISTDIR}/${P}-japanese.patch
}

src_compile() {
	econf \
		`use_enable xinerama` \
		`use_enable truetype xft` \
		--enable-shape \
		--enable-render \
		--enable-randr \
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

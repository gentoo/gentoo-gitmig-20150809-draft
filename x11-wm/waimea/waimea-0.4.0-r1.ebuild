# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.4.0-r1.ebuild,v 1.3 2003/06/24 22:03:06 vapier Exp $

inherit eutils
 
DESCRIPTION="Window manager based on BlackBox"
SRC_URI="http://www.waimea.org/files/stable/source/${P}.tar.bz2
	cjk? ( http://www.kasumi.sakura.ne.jp/~zoe/tdiary/patch/${P}-japanese.patch )"
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
	unpack ${A}
	cd ${S}
	use cjk && epatch ${DISTDIR}/${P}-ja.patch
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

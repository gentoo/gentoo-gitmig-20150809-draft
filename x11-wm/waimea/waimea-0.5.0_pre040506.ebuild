# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/waimea/waimea-0.5.0_pre040506.ebuild,v 1.3 2004/06/05 00:31:44 weeve Exp $

inherit eutils 64-bit

S="${WORKDIR}/${PN}-0.5.0"
DESCRIPTION="Window manager based on BlackBox"
# Temporary URL until SF's CVS is back online
SRC_URI="http://www.cs.umu.se/~c99drn/waimea/waimea-0.5.0-040506.tar.gz"
HOMEPAGE="http://www.waimea.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
IUSE="truetype xinerama"

DEPEND="virtual/x11
	x11-libs/cairo
	x11-libs/libsvg-cairo"

PROVIDE="virtual/blackbox"

src_unpack() {
	unpack ${A}
	cd ${S}
	64-bit && epatch ${FILESDIR}/${PN}-0.5.0-64bit-clean.patch
}

src_compile() {
	econf \
		`use_enable xinerama` \
		`use_enable truetype xft` \
		--enable-svg \
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

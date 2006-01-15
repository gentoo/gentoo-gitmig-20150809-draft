# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakd/lineakd-0.8.3-r1.ebuild,v 1.6 2006/01/15 16:48:49 nelchael Exp $

inherit eutils

IUSE=""
MY_PV=${PV/_/}
MY_P=${PN}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

RDEPEND="|| ( (
			x11-libs/libICE
			x11-libs/libSM
			x11-libs/libX11
			x11-libs/libXext )
		virtual/x11 )"

DEPEND="${RDEPEND}
		|| ( (
			x11-libs/libxkbfile
			x11-libs/libXt
			x11-proto/xextproto
			x11-proto/xproto )
		virtual/x11 )"

src_unpack() {
	unpack "${A}"
	epatch "${FILESDIR}/${P}-lineakkb.def.patch"
}

src_compile() {
	econf --with-x || die
	emake || die
}

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${P} install || die
	dodoc AUTHORS README TODO
	keepdir /usr/lib/lineakd/plugins

	insinto /etc/lineak
	doins lineakd.conf.example
	doins lineakd.conf.kde.example
}

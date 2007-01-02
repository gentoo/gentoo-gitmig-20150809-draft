# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineakd/lineakd-0.8.4.ebuild,v 1.7 2007/01/02 14:02:19 gustavoz Exp $

inherit eutils

DESCRIPTION="Linux support for Easy Access and Internet Keyboards features X11 support"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc ~sparc x86"

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
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-defconfig.patch
	epatch ${FILESDIR}/${P}-mandestdir.patch
}

src_compile() {
	econf --with-x || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${P} install || die "make install failed"
	dodoc AUTHORS README TODO
	keepdir /usr/lib/lineakd/plugins

	insinto /etc/lineak
	doins lineakd.conf.example
	doins lineakd.conf.kde.example
}

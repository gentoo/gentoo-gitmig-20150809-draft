# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libieee1284/libieee1284-0.2.8.ebuild,v 1.1 2005/01/16 23:23:01 robbat2 Exp $

inherit libtool eutils gnuconfig

DESCRIPTION="Library to query devices using IEEE1284"
HOMEPAGE="http://cyberelk.net/tim/libieee1284/index.html"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2
		 mirror://gentoo/${P}-dbjh-v4.diff.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 -ppc"
IUSE="doc"

RDEPEND="virtual/libc"
DEPEND="${RDEPEND}
		doc? ( app-text/docbook-sgml-utils
		>=app-text/docbook-sgml-dtd-4.1
		app-text/docbook-dsssl-stylesheets
		dev-perl/XML-RegExp )
		>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${DISTDIR}/${P}-dbjh-v4.diff.bz2
	aclocal || die
	autoconf || die
	libtoolize --copy --force || die
	gnuconfig_update
}

src_compile() {
	econf || die "./configure failed"
	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS NEWS README* TODO doc/interface*
}

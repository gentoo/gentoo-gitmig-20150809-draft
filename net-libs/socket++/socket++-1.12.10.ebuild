# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/socket++/socket++-1.12.10.ebuild,v 1.3 2004/12/16 04:03:48 swegener Exp $

inherit eutils

DESCRIPTION="C++ Socket Library"
HOMEPAGE="http://members.aon.at/hstraub/linux/socket++/"
SRC_URI="http://www.hstraub.at/linux/downloads/src/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
IUSE="debug"

DEPEND="=sys-devel/automake-1.7*
	=sys-devel/autoconf-2.59*
	sys-devel/libtool
	sys-apps/texinfo"
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PV}-gcc34.patch
}

src_compile() {
	WANT_AUTOMAKE=1.7 WANT_AUTOCONF=2.5  ./autogen || die "./autogen failed"
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "install failed"

	dodoc AUTHORS ChangeLog NEWS README* THANKS || die "dodoc failed"
}

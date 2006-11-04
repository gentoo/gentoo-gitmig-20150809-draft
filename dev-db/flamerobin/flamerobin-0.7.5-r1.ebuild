# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/flamerobin/flamerobin-0.7.5-r1.ebuild,v 1.1 2006/11/04 20:59:10 wltjr Exp $

inherit eutils

DESCRIPTION="A database administration tool for Firebird DBMS"
HOMEPAGE="http://www.flamerobin.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}-src.tar.gz"

LICENSE="BSD as-is"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

RDEPEND=">=x11-libs/wxGTK-2.6.0
	 dev-db/firebird"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}-src"

src_compile() {
	local myconf
	myconf="${myconf} --disable-shared --disable-debug --with-wx=yes"
	econf ${myconf} || die "Could not configure FlameRobin"
	emake || die "error during make"
}
src_install() {
	make DESTDIR="${D}" install || die "Could not install FlameRobin"

	doicon ${S}/res/fricon.xpm
	domenu ${FILESDIR}/FlameRobin.desktop

	dodoc devdocs/* docs/* docs-src/*
}


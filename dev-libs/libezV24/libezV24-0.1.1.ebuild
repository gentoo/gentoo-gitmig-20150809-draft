# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libezV24/libezV24-0.1.1.ebuild,v 1.5 2006/08/26 22:51:29 vapier Exp $

inherit eutils

DESCRIPTION="library that provides an easy API to Linux serial ports"
HOMEPAGE="http://ezv24.sourceforge.net/"
SRC_URI="mirror://sourceforge/ezv24/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 -ppc ~sparc ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-test.patch
	sed -i -e 's:__LINUX__:__linux__:' *.c *.h
	sed -i \
		-e '/^PREFIX/s:/usr/local:/usr:' \
		Makefile
}

src_install() {
	export NO_LDCONFIG="stupid"
	emake install DESTDIR="${D}" || die "Make install failed"
	dodoc AUTHORS BUGS ChangeLog HISTORY README
	dohtml api-html/*
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libcaca/libcaca-0.2.ebuild,v 1.1 2004/01/14 18:42:10 mholzer Exp $

IUSE="ncurses slang"

DESCRIPTION="A library that creates colored ASCI-art graphics"
HOMEPAGE="http://sam.zoy.org/projects/libcaca"
SRC_URI="http://sam.zoy.org/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

inherit gcc eutils

DEPEND="
	ncurses? ( >=sys-libs/ncurses-5.3 )
	slang? ( >=sys-libs/slang-1.4.2 )"

src_compile() {
	myconf=""

	use ncurses || myconf="${myconf} --disable-ncurses"
	use slang && myconf="${myconf} --enable-slang"

	econf ${myconf} || die "configure of libcaca failed"

	sed -i -e "s:src examples doc:src examples:" Makefile

	emake || die "make of libcaca failed"
	}

src_install() {
	einstall || die "make install of libcaca failed"
	dodoc AUTHORS BUGS COPYING ChangeLog INSTALL NEWS NOTES \
	README TODO
}

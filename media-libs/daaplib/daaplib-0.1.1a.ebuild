# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/daaplib/daaplib-0.1.1a.ebuild,v 1.10 2005/01/20 14:29:43 gustavoz Exp $

IUSE="static"

inherit eutils

S="${WORKDIR}/${PN}.${PV}/daaplib/src"

DESCRIPTION="a tiny, portable C++ library to read and write low-level DAAP streams in memory"
HOMEPAGE="http://www.deleet.de/projekte/daap/daaplib/"
SRC_URI="http://deleet.de/projekte/daap/daaplib/${PN}.${PV}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86 ~ppc sparc"

DEPEND="app-arch/unzip"
RDEPEND=""

src_unpack() {
	unpack ${A}

	# Use updated gentoo Makefile
	ebegin "Updating Makefile"
	cp ${FILESDIR}/${P}-Makefile ${S}/makefile
	eend $?
}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" \
	     PREFIX="/usr" \
	     LIBDEPLOY="/usr/$(get_libdir)" install || die

	use static || rm ${D}/usr/$(get_libdir)/libdaaplib.a

	dodoc ../../COPYING ../../README
}

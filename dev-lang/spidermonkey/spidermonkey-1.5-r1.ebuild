# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/spidermonkey/spidermonkey-1.5-r1.ebuild,v 1.1 2006/02/28 01:58:50 vapier Exp $

inherit eutils toolchain-funcs

MY_P="js-${PV}"
DESCRIPTION="Stand-alone JavaScript C library"
HOMEPAGE="http://www.mozilla.org/js/spidermonkey/"
SRC_URI="ftp://ftp.mozilla.org/pub/mozilla.org/js/${MY_P}.tar.gz"

LICENSE="NPL-1.1"
SLOT="0"
KEYWORDS="-*" #~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

S=${WORKDIR}/js/src

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-1.5-build.patch
}

src_compile() {
	tc-export CC LD AR
	emake -j1 -f Makefile.ref || die
}

src_install() {
	make -f Makefile.ref install DESTDIR="${D}" || die
	dodoc ../jsd/README
	dohtml README.html
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/magicfilter/magicfilter-2.3h.ebuild,v 1.2 2009/11/23 14:11:00 maekke Exp $

EAPI=2

inherit eutils toolchain-funcs

MY_P=${PN}-2.3.h

DESCRIPTION="Customizable, extensible automatic printer filter"
HOMEPAGE="http://www.pell.portland.or.us/~orc/Code/magicfilter/"
SRC_URI="http://www.pell.portland.or.us/~orc/Code/magicfilter/${MY_P}.tar.gz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="virtual/ghostscript"
RDEPEND="${DEPEND}
	virtual/lpr"

S=${WORKDIR}/${MY_P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.3d-glibc-2.10.patch
	epatch "${FILESDIR}"/${PN}-2.3h-configure.patch
	epatch "${FILESDIR}"/${PN}-2.3h-makefile.patch
}

src_configure() {
	has_version "net-print/lprng" && myconf="--with-lprng"

	export CC=$(tc-getCC)
	export AC_CPP_PROG=$(tc-getCPP)

	./configure.sh \
		--prefix="/usr" \
		--mandir="/usr/share/man" \
		--filterdir="/usr/share/magicfilter/filters" \
		${myconf} || die "configure failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

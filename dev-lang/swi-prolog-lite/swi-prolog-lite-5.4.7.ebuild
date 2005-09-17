# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/swi-prolog-lite/swi-prolog-lite-5.4.7.ebuild,v 1.1 2005/09/17 03:58:33 vapier Exp $

inherit eutils

DESCRIPTION="free, small, and standard compliant Prolog compiler"
HOMEPAGE="http://www.swi-prolog.org/"
SRC_URI="http://gollem.science.uva.nl/cgi-bin/nph-download/SWI-Prolog/pl-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc-macos ~x86"
IUSE="readline static threads"

DEPEND="sys-libs/ncurses
	readline? ( sys-libs/readline )"

S=${WORKDIR}/pl-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"/src
	epatch "${FILESDIR}"/destdir.patch
	epatch "${FILESDIR}"/${P}-install.patch
	epatch "${FILESDIR}"/${PN}-5.3.14-parallel-build.patch
	sed -i \
		-e '/COFLAGS=/s:=.*:=$CFLAGS:' \
		-e '/LDFLAGS=/s:-O3::' \
		configure || die
}

src_compile() {
	cd src
	econf \
		$(use_enable readline) \
		$(use_enable !static shared) \
		$(use_enable threads mt) \
		|| die "econf failed"
	emake || die "make failed"
}

src_install() {
	make -C src DESTDIR="${D}" install || die
	dodoc ANNOUNCE ChangeLog INSTALL INSTALL.notes PORTING README VERSION
}

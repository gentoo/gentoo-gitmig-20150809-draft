# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/p7zip/p7zip-4.27.ebuild,v 1.1 2005/09/24 12:38:06 radek Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Port of 7-Zip archiver for Unix"
HOMEPAGE="http://p7zip.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}_${PV}_src.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc-macos ~x86"
IUSE="static doc"

S=${WORKDIR}/${PN}_${PV}

src_unpack() {
	unpack ${A}
	cd ${S}
	use static && epatch ${FILESDIR}/p7zip-4.16_x86_static.patch
	sed -i \
		-e "/^CXX=/s:g++:$(tc-getCXX):" \
		-e "/^CC=/s:gcc:$(tc-getCC):" \
		-e "s:-O1 -s -fPIC:${CXXFLAGS}:" \
		makefile* || die "cleaning up makefiles"
}

src_compile() {
	emake all2 || die "compilation error"
}

src_install() {
	dobin bin/7za || die "dobin 7za"

	# currently (4.27) not needed, due to separate 7z
	#dosym 7za /usr/bin/7z
	dobin bin/7z || die "dobin 7z"

	dodir /usr/lib/${PN}
	exeinto /usr/lib/${PN}
	doexe bin/7z bin/7za
	dodir /usr/lib/${PN}/Codecs
	exeinto /usr/lib/${PN}/Codecs
	doexe bin/Codecs/*
	dodir /usr/lib/${PN}/Formats
	exeinto /usr/lib/${PN}/Formats
	doexe bin/Formats/*

	doman man1/7z.1
	doman man1/7za.1

	if use doc; then
		dodoc ChangeLog README TODO DOCS/*.txt
		dohtml -r DOCS/MANUAL/*
	fi
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-6.0-r1.ebuild,v 1.1 2008/09/27 13:29:25 betelgeuse Exp $

EAPI=2

inherit eutils

DESCRIPTION="A webserver log analyzer"
HOMEPAGE="http://www.analog.cx/"
SRC_URI="http://www.analog.cx/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-libs/libpcre-3.4
	>=media-libs/gd-1.8.4-r2[jpeg,png]
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-5.1-gentoo.diff"
	sed -i \
		-e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e 's:^DEFS.*:DEFS = -DHAVE_GD -DHAVE_PCRE -DHAVE_ZLIB:' \
		-e "s:^LIBS.*:LIBS = -lgd -lz -lpcre -lm -lpng -ljpeg:" \
		src/Makefile \
		|| die "sed failed"
}

src_compile() {
	emake -C src || die "make failed"
}

src_install() {
	dobin analog || die "dobin failed"
	newman analog.man analog.1

	dodoc README.txt Licence.txt analog.cfg
	dohtml -a html,gif,css,ico docs/*
	dohtml -r how-to
	docinto examples ; dodoc examples/*
	docinto cgi ; dodoc anlgform.pl

	insinto /usr/share/analog/images ; doins images/*
	insinto /usr/share/analog/lang ; doins lang/*
	dodir /var/log/analog
	dosym /usr/share/analog/images /var/log/analog/images
	insinto /etc/analog ; doins "${FILESDIR}/analog.cfg"
}

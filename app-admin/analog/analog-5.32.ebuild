# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-5.32.ebuild,v 1.6 2004/02/06 10:57:10 aliz Exp $

inherit eutils

DESCRIPTION="The most popular logfile analyser in the world"
HOMEPAGE="http://www.analog.cx/"
SRC_URI="http://www.analog.cx/${P}.tar.gz"

SLOT="0"
LICENSE="as-is"
KEYWORDS="x86 ~ppc sparc"

DEPEND=">=dev-libs/libpcre-3.4
	>=media-libs/libgd-1.8.4-r2
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng
	>=sys-apps/sed-4"

pkg_setup() {
	local gd_use="$(</var/db/pkg/`best_version media-libs/libgd`/USE)"
	if [ ! "`has jpeg ${gd_use}`" ] ; then
		eerror "libgd is missing jpeg support. Please add"
		eerror "'jpeg' to your USE flags, and re-emerge libgd."
		die "libgd needs jpeg support"
	fi

	return 0
}

src_unpack() {
	unpack ${A} ; cd ${S}
	epatch ${FILESDIR}/${PN}-5.1-gentoo.diff
}

src_compile() {
	ebegin "Configuring"
	sed -i -e "s:^CFLAGS.*:CFLAGS = ${CFLAGS}:" \
		-e 's:^DEFS.*:DEFS = -DHAVE_GD -DHAVE_PCRE -DHAVE_ZLIB:' \
		-e "s:^LIBS.*:LIBS = -lgd -lz -lpcre -lm -lpng -ljpeg:" \
		src/Makefile
	eend $?

	make -C src || die
}

src_install() {
	dobin analog ; newman analog.man analog.1

	dodoc README.txt Licence.txt analog.cfg
	dohtml -a html,gif,css,ico docs/*
	dohtml -r how-to
	docinto examples ; dodoc examples/*
	docinto cgi ; dodoc anlgform.pl

	insinto /usr/share/analog/images ; doins images/*
	insinto /usr/share/analog/lang ; doins lang/*
	dodir /var/log/analog
	dosym /usr/share/analog/images /var/log/analog/images
	insinto /etc/analog ; doins ${FILESDIR}/analog.cfg
}

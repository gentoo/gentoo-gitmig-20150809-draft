# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/analog/analog-5.32.ebuild,v 1.16 2004/11/12 00:27:13 agriffis Exp $

inherit eutils

DESCRIPTION="The most popular logfile analyser in the world"
HOMEPAGE="http://www.analog.cx/"
SRC_URI="http://www.analog.cx/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-libs/libpcre-3.4
	>=media-libs/gd-1.8.4-r2
	sys-libs/zlib
	media-libs/jpeg
	media-libs/libpng"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4"

pkg_setup() {
	local gd_use="$(</var/db/pkg/`best_version media-libs/gd`/USE)"
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

	make -C src || die "make failed"
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

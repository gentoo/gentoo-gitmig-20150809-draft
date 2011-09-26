# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnxml/libnxml-0.18.0.ebuild,v 1.5 2011/09/26 22:12:40 radhermit Exp $

DESCRIPTION="A C-library for parsing and writing XML 1.0/1.1 files or streams"
HOMEPAGE="http://www.autistici.org/bakunin/libnxml/doc/"
SRC_URI="http://www.autistici.org/bakunin/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="doc examples"

RDEPEND="net-misc/curl"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

src_compile() {
	econf || die "configure failed"

	emake || die "make failed"

	if use doc; then
		ebegin "Creating documentation"
		doxygen doxy.conf
		eend 0
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc; then
		dohtml doc/html/*
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/test
		doins test/*.c
	fi
}

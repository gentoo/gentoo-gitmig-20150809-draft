# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/nget/nget-0.27.ebuild,v 1.1 2004/07/15 00:36:24 swegener Exp $

DESCRIPTION="Network utility to retrieve files from an NNTP news server"
HOMEPAGE="http://nget.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~arm"
IUSE="static debug ipv6 pcre zlib"

RDEPEND="virtual/libc
	dev-libs/popt
	pcre? ( dev-libs/libpcre )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	dev-libs/uulib"

src_compile() {
	econf \
		$(use_enable debug) \
		$(use_enable ipv6) \
		$(use_with pcre) \
		$(use_with zlib) \
		|| die "econf failed"

	if use static ; then
		emake LDFLAGS="-static" || die "emake failed"
	else
		emake || die "emake failed"
	fi
}

src_install() {
	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die "install failed"

	dodoc COPYING Changelog FAQ README TODO
	newdoc .ngetrc ngetrc.sample
}

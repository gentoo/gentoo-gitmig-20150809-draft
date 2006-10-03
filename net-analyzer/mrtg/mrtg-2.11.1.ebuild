# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/mrtg/mrtg-2.11.1.ebuild,v 1.11 2006/10/03 19:21:47 jokey Exp $

DESCRIPTION="A tool to monitor the traffic load on network-links"
HOMEPAGE="http://oss.oetiker/mrtg/"
SRC_URI="http://oss.oetiker/mrtg/pub/old/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ppc ppc64 sparc x86"
IUSE="doc"

DEPEND="virtual/libc
	dev-lang/perl
	>=media-libs/gd-1.8.4"

src_install () {
	keepdir /var/lib/mrtg

	make DESTDIR="${D}" install || die "make install failed"
	rm -fr ${D}/usr/share/doc/mrtg2

	newinitd ${FILESDIR}/mrtg.rc ${PN}
	newconfd ${FILESDIR}/mrtg.confd ${PN}

	dodoc ANNOUNCE CHANGES COPYRIGHT MANIFEST README THANKS

	if use doc ; then
		docinto txt ; dodoc doc/*.txt
		cp -a contrib ${D}/usr/share/doc/${PF}/contrib
		prepalldocs
		dohtml -r doc/*.html images/*
	fi
}

pkg_postinst(){
	einfo "You must configure mrtg before being able to run it. Try cfgmaker."
	einfo "The following thread may be useful:"
	einfo "http://forums.gentoo.org/viewtopic-t-105862.html"
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmonetra/libmonetra-4.0.ebuild,v 1.2 2005/01/31 20:21:25 robbat2 Exp $

inherit eutils

DESCRIPTION="Library to allow connections to an MCVE Credit Card Processing Daemon via SSL, TCP/IP, and drop-files."
HOMEPAGE="http://www.mainstreetsoftworks.com/"
SRC_URI="ftp://ftp.mcve.com/pub/libmcve/${P}.tar.gz
		 mirror://gentoo/${PN}-4.0-destdir-ln-buildfix.patch.gz
		 http://dev.gentoo.org/~robbat2/distfiles/${PN}-4.0-destdir-ln-buildfix.patch.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-libs/openssl sys-devel/gcc"

src_unpack() {
	unpack ${P}.tar.gz
	# fix DESTDIR brokenness in upstream Makefile
	epatch ${DISTDIR}/${PN}-4.0-destdir-ln-buildfix.patch.gz
}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}

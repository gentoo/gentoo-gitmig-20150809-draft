# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmonetra/libmonetra-4.1.ebuild,v 1.2 2004/08/14 20:47:32 dholm Exp $

inherit eutils

DESCRIPTION="Library to allow connections to an MCVE Credit Card Processing Daemon via SSL, TCP/IP, and drop-files."
HOMEPAGE="http://www.mainstreetsoftworks.com/"
SRC_URI="ftp://ftp.mcve.com/pub/libmcve/${P}.tar.gz
		http://www.mainstreetsoftworks.com/freedist/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE=""
DEPEND="dev-libs/openssl sys-devel/gcc"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die "einstall failed"
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmonetra/libmonetra-4.2.2.ebuild,v 1.6 2005/11/15 14:51:51 gustavoz Exp $

DESCRIPTION="library for connecting to a MCVE Credit Card Processing Daemon via SSL, TCP/IP, and drop-files."
HOMEPAGE="http://www.mainstreetsoftworks.com/"
SRC_URI="ftp://ftp.mcve.com/pub/libmcve/${P}.tar.gz
	http://www.mainstreetsoftworks.com/freedist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ia64 ppc ppc64 s390 sparc x86"
IUSE=""
RDEPEND="dev-libs/openssl"
DEPEND="${RDEPEND}
		sys-devel/gcc"

src_install() {
	make install DESTDIR="${D}" || die "einstall failed"
	dodoc AUTHORS CAfile.pem ChangeLog INSTALL README
}

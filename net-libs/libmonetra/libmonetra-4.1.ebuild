# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libmonetra/libmonetra-4.1.ebuild,v 1.5 2004/09/25 08:23:39 vapier Exp $

inherit eutils

DESCRIPTION="library for connecting to a MCVE Credit Card Processing Daemon via SSL, TCP/IP, and drop-files."
HOMEPAGE="http://www.mainstreetsoftworks.com/"
SRC_URI="ftp://ftp.mcve.com/pub/libmcve/${P}.tar.gz
	http://www.mainstreetsoftworks.com/freedist/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~arm ~hppa ~ppc ~x86"
IUSE=""

DEPEND="dev-libs/openssl
	sys-devel/gcc"

src_install() {
	make install DESTDIR="${D}" || die "einstall failed"
}

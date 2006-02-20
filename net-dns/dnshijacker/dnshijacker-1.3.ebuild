# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnshijacker/dnshijacker-1.3.ebuild,v 1.6 2006/02/20 20:24:34 jokey Exp $

# Note: Archive file and internal directory structure lack version numbers
# so a difference in the digest file _may_ mean its a newer version
DESCRIPTION="dnshijacker is a libnet/libpcap based packet sniffer and spoofer"
HOMEPAGE="http://pedram.redhive.com/projects.php"
SRC_URI="http://pedram.redhive.com/downloads/${P}.tar.gz"
SLOT="0"

# Note: License is GPL according to correspondence with software author
# Pedram Amini <pedram@redhive.com>
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

DEPEND="net-libs/libpcap
		=net-libs/libnet-1.0*"

src_compile() {

	mv Makefile Makefile.orig
	sed -e "s|gcc |gcc ${CFLAGS} |g" Makefile.orig > Makefile || die

	make || die
}

src_install() {

	dosbin dnshijacker ask_dns answer_dns

	insinto /etc/dnshijacker
	doins ftable

	dodoc README
}

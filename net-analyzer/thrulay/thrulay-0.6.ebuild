# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/thrulay/thrulay-0.6.ebuild,v 1.1 2005/06/04 19:28:50 robbat2 Exp $

DESCRIPTION="Measure the capacity of a network by sending a bulk TCP stream over it."
HOMEPAGE="http://www.internet2.edu/~shalunov/thrulay/"
SRC_URI="${HOMEPAGE}${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND=""
#RDEPEND=""

src_compile() {
	emake OPT="${CFLAGS}"
}

src_install() {
	dobin thrulay 
	dosbin thrulayd
	dodoc LICENSE README TODO thrulay-protocol.txt
	newinitd ${FILESDIR}/thrulayd-init.d thrulayd
	newconfd ${FILESDIR}/thrulayd-conf.d thrulayd
}

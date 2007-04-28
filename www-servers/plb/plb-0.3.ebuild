# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/plb/plb-0.3.ebuild,v 1.4 2007/04/28 17:29:15 swegener Exp $

DESCRIPTION="A free high-performance HTTP load balancer"
HOMEPAGE="http://plb.sunsite.dk/"
SRC_URI="http://plb.sunsite.dk/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc ~sparc alpha"
IUSE=""

DEPEND=">=dev-libs/libevent-0.6"

src_install() {
	einstall || die

	dodoc AUTHORS CONTACT ChangeLog README NEWS THANKS

	insinto /etc/
	doins ${FILESDIR}/plb.conf
	newinitd ${FILESDIR}/plb.rc6 plb
}

pkg_postinst() {
	einfo "Before starting Pure Load Balancer, you have to edit the /etc/plb.conf file."
	echo
	ewarn "It's *really* important to read the README provided with the software."
	ewarn "Just point your browser at http://plb.sunsite.dk/README"
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/plb/plb-0.3.ebuild,v 1.2 2004/09/03 15:58:51 pvdabeel Exp $

DESCRIPTION="A free high-performance HTTP load balancer"
SRC_URI="http://plb.sunsite.dk/files/${P}.tar.gz"
HOMEPAGE="http://plb.sunsite.dk/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ppc ~sparc alpha"
IUSE=""

DEPEND="virtual/libc
	>=dev-libs/libevent-0.6"

src_compile() {
	econf || die
	emake || die "compile problem"
}

src_install() {
	einstall || die

	dodoc AUTHORS CONTACT ChangeLog README NEWS THANKS

	insinto /etc/
	doins ${FILESDIR}/plb.conf
	exeinto /etc/init.d
	newexe ${FILESDIR}/plb.rc6 plb
}

pkg_postinst() {
	einfo "Before starting Pure Load Balancer, you have to edit the /etc/plb.conf file."
	echo
	ewarn "It's *really* important to read the README provided with the software."
	ewarn "Just point your browser at http://plb.sunsite.dk/README"
}

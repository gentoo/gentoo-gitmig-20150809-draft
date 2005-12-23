# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/junkbuster/junkbuster-2.0.2-r3.ebuild,v 1.3 2005/12/23 23:07:00 vapier Exp $

inherit eutils

DESCRIPTION="Filtering HTTP proxy"
HOMEPAGE="http://internet.junkbuster.com"
SRC_URI="http://www.waldherr.org/redhat/rpm/srpm/junkbuster-2.0.2-8.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 arm ppc sparc x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/ijb20

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fixups.patch
}

src_install () {
	dosbin junkbuster || die
	newinitd "${FILESDIR}"/junkbuster.rc6 junkbuster
	insinto /etc/junkbuster
	doins blocklist config cookiefile forward imagelist

	dohtml ijbman.html ijbfaq.html
	dodoc README README.TOO README.WIN squid.txt
	doman junkbuster.1

	dodir /var/log/junkbuster
}

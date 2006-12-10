# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/boa/boa-0.94.14_rc21.ebuild,v 1.2 2006/12/10 09:06:58 beu Exp $

inherit eutils

MY_PV=${PV/_/}
DESCRIPTION="Boa - A very small and very fast http daemon"
SRC_URI="http://www.boa.org/${PN}-${MY_PV}.tar.gz"
HOMEPAGE="http://www.boa.org/"

KEYWORDS="~x86 ~sparc ~mips ~ppc ~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="tetex"
S=${WORKDIR}/${PN}-${MY_PV}
DEPEND="sys-devel/flex
	sys-devel/bison
	tetex? ( virtual/tetex )"

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
	use tetex || sed -i -e '/^all:/s/boa.dvi //' docs/Makefile
	emake docs || die "emake docs failed"
	# SLH - 2004/04/23
	# commented out - this doesn't appear to work, and I'm not tetex
	# expert, so I don't know how to fix it
	#
	# use tetex && make boa.dvi
}

src_install() {
	dosbin src/boa
	doman docs/boa.8
	dodoc docs/boa.html
	dodoc docs/boa_banner.png
	doinfo docs/boa.info
#	if use tetex; then
#		dodoc docs/boa.dvi || die
#	fi

	keepdir /var/log/boa
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin
	dodir /var/www/localhost/icons

	newconfd ${FILESDIR}/boa.conf.d boa

	exeinto /usr/lib/boa
	doexe src/boa_indexer

	newinitd ${FILESDIR}/boa.rc6 boa

	dodir /etc/boa
	insinto /etc/boa
	insopts -m700
	doins ${FILESDIR}/boa.conf
	doins ${FILESDIR}/mime.types
}

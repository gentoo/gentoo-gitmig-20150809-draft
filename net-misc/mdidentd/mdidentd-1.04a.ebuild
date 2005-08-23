# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/mdidentd/mdidentd-1.04a.ebuild,v 1.7 2005/08/23 13:20:13 flameeyes Exp $

inherit eutils

DESCRIPTION="This is an identd with provides registering of idents"
HOMEPAGE="http://druglord.freelsd.org/ezbounce/"
SRC_URI="http://druglord.freelsd.org/ezbounce/ezbounce-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="ssl"

DEPEND="virtual/libc
	ssl? ( dev-libs/openssl )"

S=${WORKDIR}/ezbounce-${PV}

pkg_setup() {
	enewgroup mdidentd
	enewuser mdidentd -1 -1 /dev/null mdidentd
}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}-security.patch
	epatch ${FILESDIR}/${PV}-pidfile.patch
}

src_compile() {
	econf `use_with ssl` || die
	emake -C mdidentd CXX_OPTIMIZATIONS="${CXXFLAGS}" || die
}

src_install() {
	dosbin mdidentd/mdidentd
	dodoc mdidentd/README

	exeinto /etc/init.d
	newexe ${FILESDIR}/mdidentd.init.d mdidentd
	insinto /etc/conf.d
	newins ${FILESDIR}/mdidentd.conf.d mdidentd
}

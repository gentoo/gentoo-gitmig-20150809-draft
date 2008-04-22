# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/omnievents/omnievents-2.6.2.ebuild,v 1.4 2008/04/22 19:53:55 drac Exp $

inherit eutils versionator

MY_P=omniEvents-$(replace_all_version_separators "_")

DESCRIPTION="An implementation of the CORBA Events Service for omniORB"
HOMEPAGE="http://www.omnievents.org"
SRC_URI="mirror://sourceforge/omnievents/${MY_P}-src.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=net-misc/omniORB-4"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_compile() {
	econf
	emake -j1 || die "emake failed."
}

src_install () {
	emake -j1 DESTDIR="${D}" install || die "emake install failed."

	doman doc/man/*

	dohtml -A xml -x man,rc -r doc/*

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/*

	diropts -m0700
	dodir /var/lib/omniEvents
	keepdir /var/lib/omniEvents

	newinitd "${FILESDIR}"/${PN}-init ${PN}
	newinitd "${FILESDIR}"/${PN}-conf ${PN}
}

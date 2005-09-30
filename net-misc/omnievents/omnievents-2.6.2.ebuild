# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/omnievents/omnievents-2.6.2.ebuild,v 1.1 2005/09/30 00:55:14 kloeri Exp $

inherit versionator

MY_PV=$(replace_all_version_separators "_")
MY_P="omniEvents-${MY_PV}"


DESCRIPTION="An implementation of the CORBA Events Service for omniORB"
SRC_URI="mirror://sourceforge/omnievents/${MY_P}-src.tar.gz"
HOMEPAGE="http://www.omnievents.org/"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND=">=net-misc/omniORB-4"

S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "Failed to configure!"
	emake -j1 || die "Failed to compile!"
}

src_install () {
	make DESTDIR=${D} install

	doman doc/man/*

	dohtml -A xml -x man,rc -r doc/*

	insinto /usr/share/doc/${PF}/examples
	doins -r examples/*

	diropts -m0700
	dodir /var/lib/omniEvents
	keepdir /var/lib/omniEvents

	install -D -m0755 ${FILESDIR}/${PN}-init ${D}/etc/init.d/${PN}
	install -D -m0644 ${FILESDIR}/${PN}-conf ${D}/etc/conf.d/${PN}
}

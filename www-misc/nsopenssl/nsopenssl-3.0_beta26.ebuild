# Copyright 1999-2005 Gentoo Foundation, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/nsopenssl/nsopenssl-3.0_beta26.ebuild,v 1.1 2005/05/21 21:12:38 port001 Exp $

inherit eutils
inherit aolserver

MY_P=${P/_/}

DESCRIPTION="nsopenssl is a module for AOLserver 4.x implementing SSL using the OpenSSL library"
HOMEPAGE="http://www.scottg.net/webtools/aolserver/modules/nsopenssl/"
SRC_URI="mirror://sourceforge/aolserver/${MY_P}-src.tar.gz"

KEYWORDS="~x86"

DEPEND=">=dev-libs/openssl-0.9.6"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

MAKE_FLAGS="OPENSSL_LIB='/usr/lib' OPENSSL_INCLUDE='/usr/include/openssl'"
TCL_MODS="https.tcl"
DOCS="README TODO ChangeLog sample-config.tcl"

src_unpack() {

	unpack ${A}

	cd ${S}

	epatch ${FILESDIR}/Makefile-${PV}.diff
	epatch ${FILESDIR}/nsd.tcl.diff

	mv nsd.tcl sample-config.tcl
}

pkg_postinst() {

	echo
	einfo "A sample configuration is provided in"
	einfo "/usr/share/doc/${PF}/sample-config.tcl.gz"
	echo
}

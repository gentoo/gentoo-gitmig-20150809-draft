# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlwrapp/xmlwrapp-0.4.0.ebuild,v 1.1 2003/03/28 13:40:56 pvdabeel Exp $

A=xmlwrapp-${PV}.tar.gz
S=${WORKDIR}/xmlwrapp-${PV}
DESCRIPTION="xmlwrapp is a modern style C++ library for working with XML data. It provides a simple and easy to use interface for the very powerful libxml2 XML parser."
SRC_URI="http://pmade.org/pjones/software/xmlwrapp/download/${A}"
HOMEPAGE="http://pmade.org/pjones/software/xmlwrapp/"
KEYWORDS="x86 ppc"
LICENSE="GPL2"
SLOT="0"

IUSE=""
DEPEND="virtual/glibc
	dev-lang/perl
	dev-libs/libxml2
	dev-libs/libxslt"
RDEPEND=${DEPEND}

inherit eutils

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-${PV}.patch
	perl configure.pl --prefix ${D}/usr
}

src_install() {
	make prefix=${D}/usr install
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlwrapp/xmlwrapp-0.4.0.ebuild,v 1.3 2003/04/25 15:31:10 vapier Exp $

inherit eutils

DESCRIPTION="modern style C++ library that provides a simple and easy interface to libxml2"
SRC_URI="http://pmade.org/pjones/software/xmlwrapp/download/${P}.tar.gz"
HOMEPAGE="http://pmade.org/pjones/software/xmlwrapp/"

KEYWORDS="x86 ppc"
LICENSE="GPL-2"
SLOT="0"

DEPEND="virtual/glibc
	dev-lang/perl
	dev-libs/libxml2
	dev-libs/libxslt"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gentoo-${PV}.patch
	perl configure.pl --prefix ${D}/usr
}

src_install() {
	make prefix=${D}/usr install || die
}

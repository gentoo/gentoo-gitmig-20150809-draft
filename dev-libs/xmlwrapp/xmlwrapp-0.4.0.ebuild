# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlwrapp/xmlwrapp-0.4.0.ebuild,v 1.5 2004/02/21 11:40:12 usata Exp $

DESCRIPTION="modern style C++ library that provides a simple and easy interface to libxml2"
SRC_URI="http://pmade.org/software/xmlwrapp/download/${P}.tar.gz"
HOMEPAGE="http://pmade.org/software/xmlwrapp/"

KEYWORDS="x86 ppc"
LICENSE="BSD"
SLOT="0"

DEPEND="virtual/glibc
	dev-lang/perl
	dev-libs/libxml2
	dev-libs/libxslt"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-gentoo.diff
	perl configure.pl --prefix /usr
	mv xmlwrapp-config xmlwrapp-config.bak
	perl configure.pl --prefix ${D}/usr
	mv xmlwrapp-config.bak xmlwrapp-config
}

src_install() {
	make prefix=${D}/usr install || die
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/xmlwrapp/xmlwrapp-0.4.1.ebuild,v 1.6 2004/09/20 16:44:48 usata Exp $

inherit eutils

DESCRIPTION="modern style C++ library that provides a simple and easy interface to libxml2"
HOMEPAGE="http://pmade.org/software/xmlwrapp/"
SRC_URI="http://pmade.org/software/xmlwrapp/download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""

DEPEND="virtual/libc
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

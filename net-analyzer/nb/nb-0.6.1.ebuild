# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nb/nb-0.6.1.ebuild,v 1.1 2005/03/14 13:38:19 eldad Exp $

DESCRIPTION="Nodebrain is a tool to monitor and do event correlation."
HOMEPAGE="http://www.nodebrain.org/"
SRC_URI="mirror://sourceforge/nodebrain/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.6.0"

src_compile() {
	./build-nb || die
}

src_install() {
	DIR=${D}/usr ./install-nb || die

	exeinto /usr/bin
	doexe bin/nb*

	dodoc AUTHORS NEWS README THANKS sample/*
	dohtml html/*
}



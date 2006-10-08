# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nb/nb-0.6.5.ebuild,v 1.1 2006/10/08 21:58:34 jokey Exp $

DESCRIPTION="Nodebrain is a tool to monitor and do event correlation."
HOMEPAGE="http://www.nodebrain.org/"
SRC_URI="mirror://sourceforge/nodebrain/${P}-source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

src_compile() {
	./build-nb || die "build failed"
}

src_install() {
	DIR=${D}/usr ./install-nb || die "install failed"
}
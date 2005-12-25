# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/cxterm/cxterm-5.2.3.ebuild,v 1.7 2005/12/25 19:59:35 usata Exp $

SRC_URI="mirror://sourceforge/${PN}/${P}.tgz"
HOMEPAGE="http://cxterm.sourceforge.net/"
DESCRIPTION="A Chinese/Japanese/Korean X-Terminal"

DEPEND="virtual/x11
	>=sys-apps/sed-4"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86"
IUSE=""

src_install() {

	make DESTDIR=${D} install || die

	dodoc README* INSTALL-5.2 Doc/*
	docinto tutorial-1
	dodoc Doc/tutorial-1/*
	docinto tutorial-2
	dodoc Doc/tutorial-2/*
}

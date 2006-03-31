# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/rubber/rubber-1.1.ebuild,v 1.1 2006/03/31 16:36:41 nattfodd Exp $

inherit distutils eutils

IUSE=""

DESCRIPTION="A LaTeX wrapper for automatically building documents"
HOMEPAGE="http://rubber.sourceforge.net/"
SRC_URI="http://ebeffara.free.fr/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND=">=dev-lang/python-2.2
		virtual/tetex"


src_compile() {
	# configure script is not created by GNU autoconf
	./configure --prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die
	emake || die
}

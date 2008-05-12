# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-tex/rubber/rubber-0.99.8.ebuild,v 1.4 2008/05/12 12:55:59 aballier Exp $

inherit distutils eutils

IUSE=""

DESCRIPTION="A LaTeX wrapper for automatically building documents"
HOMEPAGE="http://iml.univ-mrs.fr/~beffara/soft/rubber/"
SRC_URI="http://ebeffara.free.fr/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"

DEPEND="dev-lang/python"

#src_unpack() {
#	unpack ${A}
#	cd ${S}
#	epatch ${FILESDIR}/rubber-module-command.patch
#}

src_compile() {
	# configure script is not created by GNU autoconf
	./configure --prefix=/usr \
		--bindir=/usr/bin \
		--datadir=/usr/share \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info || die
	emake || die
}

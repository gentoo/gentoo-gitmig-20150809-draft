# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cream/cream-0.29.ebuild,v 1.2 2004/04/27 20:43:53 agriffis Exp $

inherit vim-plugin eutils

DESCRIPTION="Cream is an easy-to-use configuration of the GVim text editor"
HOMEPAGE="http://cream.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~mips ppc"
IUSE=""
DEPEND=""
RDEPEND=">=app-editors/gvim-6.2"
S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/gentoo-${P}-mkdir.patch
	cd $S
	# Make the install script handle it. Point it to the destination dir.
	# We handle docs ourselves.
	sed -i~ -e s:/usr/:${D}usr/:g -e /docs/d INSTALL.sh
}
src_install() {
	cd $S
	dodir /usr/bin /usr/share/icons /usr/share/applications
	./INSTALL.sh
	dodoc docs/*
	dohtml docs-html/*
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostview/ghostview-1.5.ebuild,v 1.6 2002/08/14 10:31:35 pvdabeel Exp $ 

S=${WORKDIR}/${P}
DESCRIPTION="A PostScript viewer for X11"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/ghostview/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc
        virtual/x11"

RDEPEND="${DEPEND}
	>=app-text/ghostscript-6.50-r2"

src_unpack() { 
	unpack ${A}
	# This patch contains all the Debian patches and enables anti-aliasing.
	patch -p0 < ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	PATH=/usr/X11R6/bin:${PATH} # root doesn't get this by default
	xmkmf -a || die
	cp Makefile Makefile.old
	sed -e "s,all:: ghostview.\$(MANSUFFIX).html,all:: ,g" Makefile.old > Makefile
	emake || die
}

src_install() {
	dobin ghostview
	newman ghostview.man ghostview.1
	insinto /etc/X11/app-defaults
	newins Ghostview.ad Ghostview
	dodoc COPYING HISTORY README comments.doc
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostview/ghostview-1.5-r1.ebuild,v 1.6 2003/09/05 22:37:21 msterret Exp $

inherit eutils

DESCRIPTION="A PostScript viewer for X11"
HOMEPAGE="http://www.gnu.org/software/ghostview/"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/glibc
	virtual/x11"
RDEPEND="${DEPEND}
	>=app-text/ghostscript-6.50-r2"

src_unpack() {
	unpack ${A}
	# This patch contains all the Debian patches and enables anti-aliasing.
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	PATH=/usr/X11R6/bin:${PATH} # root doesn't get this by default
	xmkmf -a || die
	cp Makefile Makefile.old
	sed -e "s:CDEBUGFLAGS = .*:CDEBUGFLAGS = ${CFLAGS} -fno-strength-reduce:" \
		-e "s,all:: ghostview.\$(MANSUFFIX).html,all:: ,g" \
		Makefile.old > Makefile
	emake || die
}

src_install() {
	dobin ghostview
	newman ghostview.man ghostview.1
	insinto /etc/X11/app-defaults
	newins Ghostview.ad Ghostview
	dodoc COPYING HISTORY README comments.doc
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostview/ghostview-1.5.ebuild,v 1.21 2004/10/25 07:59:48 usata Exp $

inherit eutils

DESCRIPTION="A PostScript viewer for X11"
HOMEPAGE="http://www.gnu.org/software/ghostview/"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"
RDEPEND="${DEPEND}
	virtual/ghostscript"
PROVIDE="virtual/pdfviewer
	virtual/psviewer"

src_unpack() {
	unpack ${A}
	# This patch contains all the Debian patches and enables anti-aliasing.
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	PATH=/usr/X11R6/bin:${PATH} # root doesn't get this by default
	xmkmf -a || die
	sed -i -e "s,all:: ghostview.\$(MANSUFFIX).html,all:: ,g" Makefile
	emake || die
}

src_install() {
	dobin ghostview
	newman ghostview.man ghostview.1
	insinto /etc/X11/app-defaults
	newins Ghostview.ad Ghostview
	dodoc COPYING HISTORY README comments.doc
}

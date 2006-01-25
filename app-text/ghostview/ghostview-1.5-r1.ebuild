# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/ghostview/ghostview-1.5-r1.ebuild,v 1.20 2006/01/25 18:29:34 spyderous Exp $

inherit eutils

DESCRIPTION="A PostScript viewer for X11"
HOMEPAGE="http://www.gnu.org/software/ghostview/"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""

RDEPEND="|| ( ( x11-libs/libXaw
			x11-misc/xbitmaps
		)
		virtual/x11
	)
	virtual/ghostscript"
DEPEND="${RDEPEND}
	virtual/libc
	|| ( ( x11-misc/imake
			x11-misc/gccmakedep
		)
		virtual/x11
	)"
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
	sed -i -e "s:CDEBUGFLAGS = .*:CDEBUGFLAGS = ${CFLAGS} -fno-strength-reduce:" \
		-e "s,all:: ghostview.\$(MANSUFFIX).html,all:: ,g" \
		Makefile
	emake || die
}

src_install() {
	dobin ghostview
	newman ghostview.man ghostview.1
	insinto /etc/X11/app-defaults
	newins Ghostview.ad Ghostview
	dodoc COPYING HISTORY README comments.doc
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.6.1.ebuild,v 1.1 2005/06/07 09:58:37 lanius Exp $

inherit eutils

DESCRIPTION="standard ghostscript frontend used by programs like LyX"
HOMEPAGE="http://www.gnu.org/software/gv/"
SRC_URI="ftp://ftp.gnu.org/gnu/gv/${P}.tar.gz
	mirror://debian/pool/main/g/gv/gv_3.6.1-10.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64 ~mips ~ppc-macos ~ppc64"
IUSE=""

# There's probably more, but ghostscript also depends on it,
# so I can't identify it
DEPEND="virtual/x11
	x11-libs/Xaw3d
	virtual/ghostscript"
PROVIDE="virtual/pdfviewer
	virtual/psviewer"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-landscape.patch
	epatch ${FILESDIR}/${P}-setenv.patch
	epatch ${FILESDIR}/${P}-a0.patch
	epatch ${DISTDIR}/gv_3.6.1-10.diff.gz
}

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall destdir=${D} || die
	dodoc AUTHORS ChangeLog INSTALL README TODO
}

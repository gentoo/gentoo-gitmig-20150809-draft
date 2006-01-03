# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gv/gv-3.6.1.ebuild,v 1.3 2006/01/03 09:57:25 genstef Exp $

inherit eutils

DESCRIPTION="gv is used to view PostScript and PDF documents using Ghostscript"
HOMEPAGE="http://www.gnu.org/software/gv/"
SRC_URI="ftp://ftp.gnu.org/gnu/gv/${P}.tar.gz
	mirror://debian/pool/main/g/gv/gv_3.6.1-10.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~amd64 ~mips ~ppc-macos ~ppc64"
IUSE=""

RDEPEND="|| ( (
			x11-libs/libXmu
			x11-libs/libXpm
			x11-libs/libXp
		) virtual/x11
	)
	x11-libs/Xaw3d
	virtual/ghostscript"

# There's probably more, but ghostscript also depends on it,
# so I can't identify it
DEPEND="${RDEPEND}
	|| ( (
			x11-misc/imake
			x11-libs/libXt
		) virtual/x11
	)"
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

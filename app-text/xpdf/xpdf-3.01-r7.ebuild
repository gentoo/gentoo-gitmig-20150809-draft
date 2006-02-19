# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xpdf/xpdf-3.01-r7.ebuild,v 1.13 2006/02/19 16:45:51 geoman Exp $

inherit eutils

DESCRIPTION="An X Viewer for PDF Files"
HOMEPAGE="http://www.foolabs.com/xpdf/"
SRC_URI="http://dev.gentoo.org/~genstef/files/dist/${P}-poppler.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sh sparc x86"
IUSE="nodrm"

RDEPEND=">=app-text/poppler-0.5.0-r4
	virtual/motif
	|| (
		( x11-libs/libX11 x11-libs/libXpm )
		virtual/x11
	)"
DEPEND="${RDEPEND}"
PROVIDE="virtual/pdfviewer"

S=${WORKDIR}/${P}-poppler

src_unpack() {
	unpack ${A}
	cd "${S}"
	use nodrm && epatch "${FILESDIR}"/${P}-poppler-nodrm.patch
}

src_install() {
	dobin xpdf
	doman xpdf.1
	dodoc README ANNOUNCE CHANGES
}

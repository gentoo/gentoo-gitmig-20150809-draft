# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gocr/gocr-0.47.ebuild,v 1.1 2009/04/29 22:53:15 aballier Exp $

inherit eutils

DESCRIPTION="An OCR (Optical Character Recognition) reader"
HOMEPAGE="http://jocr.sourceforge.net"
SRC_URI="mirror://sourceforge/jocr/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc tk"

DEPEND=">=media-libs/netpbm-9.12
	doc? ( >=media-gfx/transfig-3.2 virtual/ghostscript )
	tk? ( dev-lang/tk )"

DOCS="AUTHORS BUGS CREDITS HISTORY RE* TODO"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-makefile.patch"
}

src_compile() {
	local mymakes="src man"

	use doc && mymakes="${mymakes} doc examples"

	econf || die "econf failed"
	emake ${mymakes} || die "make ${mymakes} failed"
}

src_install() {
	emake DESTDIR="${D}" prefix="/usr"  exec_prefix="/usr" install || die "make install failed"
	# remove the tk frontend if tk is not selected
	use tk || rm "${D}"/usr/bin/gocr.tcl
	# and install the documentation and examples
	if use doc ; then
		DOCS="${DOCS} doc/gocr.html doc/examples.txt doc/unicode.txt"
		insinto /usr/share/doc/${P}/examples
		doins "${S}"/examples/*.{fig,tex,pcx}
	fi
	# and then install all the docs
	dodoc ${DOCS}
}

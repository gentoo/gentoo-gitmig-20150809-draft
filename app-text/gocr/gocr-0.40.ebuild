# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/gocr/gocr-0.40.ebuild,v 1.3 2006/04/23 17:40:56 corsair Exp $

DESCRIPTION="An OCR (Optical Character Recognition) reader"
HOMEPAGE="http://jocr.sourceforge.net"
SRC_URI="mirror://sourceforge/jocr/${P}.tar.gz"
LICENSE="GPL-2"

IUSE="gtk doc"
SLOT="0"
KEYWORDS="~amd64 ~ppc ppc64 ~sparc ~x86"

DEPEND=">=media-libs/netpbm-9.12
	doc? ( >=media-gfx/transfig-3.2 )
	gtk? ( =x11-libs/gtk+-1* )"

DOCS="AUTHORS BUGS CREDITS HISTORY INSTALL RE* TODO"

src_unpack() {

	unpack ${A}
	# fix for erroneous Makefile in frontend/
	cd ${S}/frontend
	sed -i -e "s/configure/\.\/configure/" Makefile

}

src_compile() {

	local mymakes="src man"

	use gtk && mymakes="${mymakes} frontend"
	use doc && mymakes="${mymakes} doc examples"

	econf || die
	make ${mymakes} || die

}

src_install() {

	make DESTDIR="${D}" prefix="/usr"  exec_prefix="/usr" install || die
	# install the gtk frontend
	use gtk && dobin ${S}/frontend/gnome/src/gtk-ocr
	# and install the documentation and examples
	if use doc ; then
		DOCS="${DOCS} doc/gocr.html doc/examples.txt doc/unicode.txt"
		insinto /usr/share/doc/${P}/examples
		doins ${S}/examples/*.{fig,tex,pcx}
	fi
	# and then install all the docs	
	dodoc ${DOCS}

}

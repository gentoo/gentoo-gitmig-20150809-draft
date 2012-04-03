# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.11.ebuild,v 1.2 2012/04/03 03:12:04 vapier Exp $

EAPI=4

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI="mirror://nongnu/${PN}/${P}.tar.gz
	doc? (
		mirror://nongnu/${PN}/${PN}-doc-${PV}.tar.gz
		mirror://nongnu/${PN}/${PN}-doc-${PV}.pdf
	)"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~ppc64 ~x86"
IUSE="doc"

RDEPEND="virtual/libusb"
DEPEND="${RDEPEND}"

DOCS="AUTHORS ChangeLog* NEWS README"

src_prepare() {
	# let the build system re-generate these, bug #120194
	rm -f lexer.c config_gram.c config_gram.h
}

src_compile() {
	# The automake target for these files does not use tempfiles or create
	# these atomically, confusing a parallel build. So we force them first.
	emake lexer.c config_gram.c config_gram.h
	emake
}

src_install() {
	default

	if use doc ; then
		newdoc "${DISTDIR}/${PN}-doc-${PV}.pdf" avrdude.pdf
		dohtml -r "${WORKDIR}/avrdude-html/"
	fi
}

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-embedded/avrdude/avrdude-5.10.ebuild,v 1.1 2010/11/17 23:13:29 xmw Exp $

EAPI=2

inherit eutils

DESCRIPTION="AVR Downloader/UploaDEr"
HOMEPAGE="http://savannah.nongnu.org/projects/avrdude"
SRC_URI_BASE="http://savannah.nongnu.org/download/${PN}"
SRC_URI="${SRC_URI_BASE}/${P}.tar.gz
	doc? ( ${SRC_URI_BASE}/${PN}-doc-${PV}.tar.gz
		   ${SRC_URI_BASE}/${PN}-doc-${PV}.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~ppc ~ppc64 ~x86"

IUSE="doc"

RDEPEND="virtual/libusb"
DEPEND="${RDEPEND}"

src_prepare() {
	# let the build system re-generate these, bug #120194
	rm -f lexer.c config_gram.c config_gram.h

	epatch "${FILESDIR}/${P}-jtagmkII-debugWire.patch"
}

src_compile() {
	# The automake target for these files does not use tempfiles or create these
	# atomically, confusing a parallel build. So we force them first.
	emake lexer.c config_gram.c config_gram.h || die "emake of lexer failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	dodoc AUTHORS ChangeLog* NEWS README || die "dodoc failed"

	if use doc ; then
		newdoc "${DISTDIR}/${PN}-doc-${PV}.pdf" avrdude.pdf || \
			die "newdoc	failed"
		dohtml -r "${WORKDIR}/avrdude-html/" || die "dohtml failed"
	fi
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxspace/fluxspace-0.0.3-r1.ebuild,v 1.9 2007/02/19 00:50:31 dirtyepic Exp $

inherit eutils

IUSE=""
DESCRIPTION="Enhancements for workspace management within Fluxbox."
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
HOMEPAGE="http://fluxspace.sourceforge.net/"

DEPEND="dev-lang/swig"
RDEPEND="x11-wm/fluxbox
		>=dev-lang/python-2.1
		dev-python/pyxml
		media-libs/imlib2"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ppc ~sparc x86"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc41.patch
}

src_compile() {
	econf || die "Configure failed"
	emake || die "Compile failed"
}

src_install () {
	einstall || die "Install failed"
	dosym /usr/lib/python2.2/site-packages/fluxspace.py \
			/usr/lib/python2.2/site-packages/fluxspace/__init__.py
	dosym /usr/lib/libfluxspace.so \
			/usr/lib/python2.2/site-packages/_fluxspace.so
	dodoc README COPYING AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	elog " NOTES:"
	elog
	elog " 1. If you want to use the optional features for idesk and rox,"
	elog "    you must emerge them separately. (e.g., 'emerge idesk')"
	elog
	elog " 2. Copy /usr/share/fluxspace/examples/fluxspace.xml to"
	elog "    ~/.fluxbox and edit the file.  Change the settings from"
	elog "    \"no\" to \"yes\" depending on what features you want enabled."
	elog
	elog " 3. Edit ~/.fluxbox/init to 'turn on' fluxspace.  Change line:"
	elog "        session.screen0.rootCommand:"
	elog "    to..."
	elog "        session.screen0.rootCommand: fluxspace"
	elog
	elog " 4. Full documentation is available online at:"
	elog "    http://sourceforge.net/docman/display_doc.php?docid=16037&group_id=76737"
	elog
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/fluxspace/fluxspace-0.0.3-r1.ebuild,v 1.6 2005/04/03 06:06:52 ka0ttic Exp $

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
KEYWORDS="x86 ppc ~sparc"

myconf="--prefix=/usr"

src_compile() {
	export LDFLAGS="-lstdc++"
	econf ${myconf} || die "Configure failed"
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
	# Fix typo in the config file
	sed -e "s/no\"\\\/no\"\//g" /usr/share/fluxspace/examples/fluxspace.xml > /tmp/fluxspace.xml
	cp -f /tmp/fluxspace.xml /usr/share/fluxspace/examples/fluxspace.xml
	rm -f /tmp/fluxspace.xml

	einfo " NOTES:"
	einfo " "
	einfo " 1. If you want to use the optional features for idesk and rox,"
	einfo "    you must emerge them separately. (e.g., 'emerge idesk')"
	einfo " "
	einfo " 2. Copy /usr/share/fluxspace/examples/fluxspace.xml to"
	einfo "    ~/.fluxbox and edit the file.  Change the settings from"
	einfo "    \"no\" to \"yes\" depending on what features you want enabled."
	einfo " "
	einfo " 3. Edit ~/.fluxbox/init to 'turn on' fluxspace.  Change line:"
	einfo "        session.screen0.rootCommand:"
	einfo "    to..."
	einfo "        session.screen0.rootCommand: fluxspace"
	einfo " "
	einfo " 4. Full documentation is available online at:"
	einfo "    http://sourceforge.net/docman/display_doc.php?docid=16037&group_id=76737"
	einfo " "
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="Enhancements for workspace management within Fluxbox."
SRC_URI="http://www.isomedia.com/homes/stevencooper/files/${P}.tar.gz"
HOMEPAGE="http://www.isomedia.com/homes/stevencooper/"
DEPEND="x11-wm/fluxbox
		x11-misc/idesk
		app-misc/rox
		media-libs/imlib2
		dev-lang/python
		dev-python/PyXML
		dev-lang/swig"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc"

myconf="--prefix=/usr"

src_compile() {
	export LDFLAGS="-lstdc++"
	econf ${myconf} || die
	emake || die
}

src_install () {
	einstall || die
	dosym /usr/lib/python2.2/site-packages/fluxspace.py /usr/lib/python2.2/site-packages/fluxspace/__init__.py
	dosym /usr/lib/libfluxspace.so /usr/lib/python2.2/site-packages/_fluxspace.so
	dodoc README COPYING AUTHORS ChangeLog NEWS README TODO
}

pkg_postinst() {
	# there is a typo in the xml file, so i'll fix it =)

	sed -e "s/no\"\\\/no\"\//g" /usr/share/fluxspace/examples/fluxspace.xml > /tmp/fluxspace.xml
	cp -f /tmp/fluxspace.xml /usr/share/fluxspace/examples/fluxspace.xml
	rm -f /tmp/fluxspace.xml

	einfo " "
	einfo "  Copy /usr/share/fluxspace/examples/fluxspace.xml to your"
	einfo "  ~/.fluxbox and edit it!"
	einfo "  (just to make it work change all the \"no\" to \"yes\")"
	einfo " "
	einfo "  In your ~/.fluxbox/init change:"
	einfo "                       session.screen0.rootCommand:"
	einfo "  to:"
	einfo "                       session.screen0.rootCommand:    fluxspace"
	einfo " "
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.4.0-r1.ebuild,v 1.1 2002/07/18 20:09:31 spider Exp $


S=${WORKDIR}/${P}
DESCRIPTION="Streaming media framework"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.gz"
HOMEPAGE="http://gstreamer.sourceforge.net"
LICENSE="LGPL-2"
KEYWORDS="x86"
SLOT="0"

# required packages
# there are many many optional libraries. features are compiled if the libraries
# are present. most optional libraries are from gnome.
DEPEND=">=dev-libs/glib-2.0
	>=dev-libs/libxml2-2.4
	>=dev-libs/popt-1.5
	doc? ( >=dev-util/gtk-doc-0.9 
		media-gfx/transfig 
		dev-libs/libxslt
		app-text/xmltex
		app-text/xpdf
		app-text/ghostscript )
	>=dev-lang/nasm-0.90
	>=sys-libs/zlib-1.1.4"
	
RDEPEND=">=dev-libs/glib-2.0
	>=dev-libs/libxml2-2.4
	>=dev-libs/popt-1.5
	>=sys-libs/zlib-1.1.4"


src_compile() {
	local myconf
	use doc && myconf="${myconf} --enable-docs-build" || myconf="${myconf} --disable-docs-build"

	# gtkdoc-fixxref should do its stuff in DESTDIR
	pushd docs/libs
	cat Makefile.am | sed 's/\(gtkdoc-fixxref.*html-dir=\)/\1$(DESTDIR)/' > Makefile.am.new
	mv Makefile.am.new Makefile.am
	popd

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--sysconfdir=/etc \
		${myconf} \
		--mandir=/usr/share/man \
		--with-configdir=/etc/gstreamer \
		--disable-tests  --disable-examples || die "./configure failed"
	emake || die "build failed miserably" 
}

src_install () {
	make DESTDIR=${D} install || die
	# gtkdoc will install stuff in a directory with wrong name (wrong after my opinion)
	# fix it:
	mv ${D}/usr/share/doc/${P} ${D}/usr/share/doc/${PF}
	# now have to clean after gtkdoc-fixxref
	prepalldocs
	dodoc AUTHORS COPYING COPYING.LIB INSTALL README RELEASE REQUIREMENTS TODO
	# will do these later - must do some recursive stuff about it... (with find???)
	# docs/random/*
	# examples/*
	# get all those html manuals and stuff like that.
	dohtml -r docs/fwg/gts-plugin-writers-guide
	dohtml -r docs/gst/html
	dohtml -r docs/manual/gstreamer-manual
}

pkg_postinst () {
	gst-register
}

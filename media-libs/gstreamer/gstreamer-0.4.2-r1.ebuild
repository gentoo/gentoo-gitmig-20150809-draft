# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.4.2-r1.ebuild,v 1.1 2002/11/04 11:34:46 leonardop Exp $

inherit flag-o-matic

IUSE="doc"

S=${WORKDIR}/${P}

DESCRIPTION="Streaming media framework"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.bz2"
HOMEPAGE="http://gstreamer.sourceforge.net"

SLOT="0"
LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~sparc64"

DEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4
	>=dev-libs/popt-1.5
	doc? ( >=dev-util/gtk-doc-0.9 
		media-gfx/transfig 
		dev-libs/libxslt
		app-text/xmltex
		app-text/xpdf
		app-text/ghostscript )
	x86? ( >=dev-lang/nasm-0.90 )
	>=sys-libs/zlib-1.1.4"
	
src_unpack() {
	unpack ${A}
	cd ${S}
	# patch for problems compiling when specifying USE="doc"
	patch -p1 < ${FILESDIR}/xsl.diff || die "patch failed"
}

src_compile() {
	strip-flags
	replace-flags "-O3" "-O2"

	local myconf
	use doc \
		&& myconf="${myconf} --enable-docs-build" \
		|| myconf="${myconf} --disable-docs-build"

	econf \
		--with-configdir=/etc/gstreamer \
		--disable-tests  --disable-examples \
		${myconf} || die "./configure failed"

	emake || die "compile failed"
}

src_install () {
	einstall || die "Installation failed"

	dodoc AUTHORS ChangeLog COPYING* DEVEL NEWS \
		README RELEASE REQUIREMENTS TODO
}

pkg_postinst () {
	gst-register
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/gstreamer/gstreamer-0.5.2.ebuild,v 1.5 2003/09/06 23:59:48 msterret Exp $

inherit eutils flag-o-matic libtool

IUSE="doc"

S="${WORKDIR}/${P}"
DESCRIPTION="Streaming media framework"
SRC_URI="mirror://sourceforge/gstreamer/${P}.tar.bz2"
HOMEPAGE="http://gstreamer.sourceforge.net"

SLOT="0.5"
LICENSE="LGPL-2"
KEYWORDS="x86 ~ppc ~sparc "

DEPEND=">=dev-libs/glib-2.0.4
	>=dev-libs/libxml2-2.4
	>=dev-libs/popt-1.5
	doc? ( >=dev-util/gtk-doc-0.9
		media-gfx/transfig
		dev-libs/libxslt
		app-text/docbook-xsl-stylesheets
		app-text/passivetex
		app-text/xpdf
		app-text/ghostscript )
	x86? ( >=dev-lang/nasm-0.90 )
	>=sys-libs/zlib-1.1.4"

src_unpack() {
	unpack ${A}

	# Patch for problems compiling when specifying USE="doc"
	# The problem is that gstreamer's docs import the wrong version
	# (or different to ours) of app-text/docbook-xsl-stylesheets,
	# and delete files it should not.
	# <azarah@gentoo.org> (27 Dec 2002).
	cd ${S}
#	epatch ${FILESDIR}/${PN}-0.5.0-xsl-use-current.patch
#	epatch ${FILESDIR}/${PN}-0.5.1-no-rm-html.devhelp.patch
}

src_compile() {
	elibtoolize

	strip-flags
	replace-flags "-O3" "-O2"

	local myconf=""
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

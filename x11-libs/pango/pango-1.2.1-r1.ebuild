# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/pango/pango-1.2.1-r1.ebuild,v 1.6 2003/07/01 17:45:32 gmsoft Exp $

inherit eutils libtool

IUSE="doc"
SLOT="1"
KEYWORDS="x86 ppc alpha ~sparc hppa"

S="${WORKDIR}/${P}"
DESCRIPTION="Text rendering and Layout library"
SRC_URI="ftp://ftp.gtk.org/pub/gtk/v2.2/${P}.tar.bz2"
HOMEPAGE="http://www.pango.org/"
LICENSE="LGPL-2.1"

RDEPEND="virtual/x11
	virtual/xft
	>=dev-libs/glib-2.1.3
	>=media-libs/freetype-2.1.2-r2"
#	>=media-libs/fontconfig-2
	
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	doc? ( >=dev-util/gtk-doc-0.9 )"

src_unpack() {
	unpack ${A}

	cd ${S}
	# Some enhancements from Redhat
	epatch ${FILESDIR}/pango-1.0.99.020606-xfonts.patch
	# patch adapted from RH initial patch by <foser@gentoo.org>
	epatch ${FILESDIR}/${P}-slighthint-gentoo.patch
	# caching fontsets speedup patch from cvs
	epatch ${FILESDIR}/${P}-cvs_fontset_caching.patch
}

src_compile() {
	elibtoolize
	local myconf=""
	use doc && myconf="--enable-gtk-doc" || myconf="--disable-gtk-doc"
	if [ -n "$DEBUGBUILD" ]; then
		myconf="${myconf}  --enable-debug"
	fi
	
	econf ${myconf} --without-qt  || die
	make || die "serial make failed" 
}

src_install() {
	einstall
	rm ${D}/etc/pango/pango.modules

 	dodoc AUTHORS ChangeLog COPYING README INSTALL NEWS TODO*
}

pkg_postinst() {
	pango-querymodules >/etc/pango/pango.modules
}

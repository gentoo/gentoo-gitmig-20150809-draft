# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmathview/gtkmathview-0.8.0.ebuild,v 1.10 2009/05/10 15:53:42 ssuominen Exp $

inherit eutils

DESCRIPTION="Rendering engine for MathML documents"
HOMEPAGE="http://helm.cs.unibo.it/mml-widget/"
SRC_URI="http://helm.cs.unibo.it/mml-widget/sources/${P}.tar.gz"

LICENSE="LGPL-3"

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="gtk svg t1lib"

RDEPEND=">=dev-libs/glib-2.2.1
		 >=dev-libs/popt-1.7
		 >=dev-libs/libxml2-2.6.7
		 gtk?	(
		 			>=x11-libs/gtk+-2.2.1
					>=media-libs/t1lib-5
		 			>=dev-libs/gmetadom-0.1.8
					  x11-libs/pango
				)
		 t1lib?	( >=media-libs/t1lib-5 )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gcc44.patch \
		"${FILESDIR}"/${P}-cond-t1.patch
}

src_compile() {
	# --disable-popt will build only the library and not the frontend
	# TFM is needed for SVG, default value is 2
	econf $(use_enable gtk) $(use_enable gtk gmetadom) \
		$(use_enable svg) \
		$(use_with t1lib) \
		--enable-popt \
		--enable-libxml2 \
		--enable-libxml2-reader \
		--enable-ps \
		--enable-tfm=2 \
		--enable-builder-cache \
		--enable-breaks \
		--enable-boxml \
		|| die "configure failed"
	emake || die "make failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ANNOUNCEMENT AUTHORS BUGS CONTRIBUTORS ChangeLog HISTORY NEWS TODO
}

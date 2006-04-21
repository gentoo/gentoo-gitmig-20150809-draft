# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkmathview/gtkmathview-0.7.6.ebuild,v 1.3 2006/04/21 19:56:39 tcort Exp $

DESCRIPTION="Rendering engine for MathML documents"
HOMEPAGE="http://helm.cs.unibo.it/mml-widget/"
SRC_URI="http://helm.cs.unibo.it/mml-widget/sources/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk svg t1lib xml2"

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

src_compile() {
	# --disable-popt will build only the library and not the frontend
	local myconf="--enable-popt --enable-libxml2 --enable-libxml2-reader"

	if use gtk ; then
		myconf="${myconf} --enable-gmetadom"
	fi

	# other options
	myconf="${myconf} --enable-builder-cache --enable-breaks --enable-boxml"

	econf $(use_enable debug) \
		  $(use_enable gtk) $(use_enable gtk gmetadom) \
		  $(use_enable svg) \
		  $(use_with t1lib) \
		  ${myconf} || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "install failed"
	dodoc ANNOUNCEMENT AUTHORS BUGS CONTRIBUTORS ChangeLog HISTORY NEWS TODO
}

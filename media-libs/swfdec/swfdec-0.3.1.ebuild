# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/swfdec/swfdec-0.3.1.ebuild,v 1.2 2004/11/17 11:38:47 lu_zero Exp $

inherit eutils

DESCRIPTION="Macromedia Flash decoding library"
HOMEPAGE="http://swfdec.sourceforge.net"
#SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
SRC_URI="http://www.schleef.org/${PN}/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
# Excluding other keywords until those arches can test liboil
#KEYWORDS="~x86 ~ppc ~amd64 ~sparc"
KEYWORDS="~x86 ~ppc"

IUSE="X mozilla gtk sdl mad"

RDEPEND=">=dev-libs/glib-2
	media-libs/libart_lgpl
	>=dev-libs/liboil-0.2.0
	gtk? ( >=x11-libs/gtk+-2.2 )
	sdl? ( media-libs/libsdl )
	mad? ( media-sound/madplay )
	>=sys-libs/zlib-1.1.4
	mozilla? ( >=net-www/mozilla-1.0.0 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {

	use mozilla && PATH=/usr/lib/mozilla:$PATH

	econf `use_with X x` `use_enable gtk pixbuf-loader` || die
	emake || die

}

src_install() {

	einstall || die

	dodoc AUTHORS COPYING ChangeLog INSTALL NEWS README RELEASE TODO

}

pkg_postinst() {

	use gtk && gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders

}

pkg_postrm() {

	use gtk && gdk-pixbuf-query-loaders > /etc/gtk-2.0/gdk-pixbuf.loaders

}

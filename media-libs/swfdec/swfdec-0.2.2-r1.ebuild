# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/swfdec/swfdec-0.2.2-r1.ebuild,v 1.10 2005/03/23 16:18:18 seemant Exp $

inherit eutils

DESCRIPTION="Macromedia Flash decoding library"
HOMEPAGE="http://swfdec.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ppc ~amd64 ~sparc"

IUSE="X mozilla gtk sdl mad"

RDEPEND=">=dev-libs/glib-2
	media-libs/libart_lgpl
	gtk? ( >=x11-libs/gtk+-2.2 )
	sdl? ( media-libs/libsdl )
	mad? ( media-sound/madplay )
	>=sys-libs/zlib-1.1.4
	mozilla? ( >=www-client/mozilla-1.0.0 )"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {

	unpack ${A}

	cd ${P}
	use mozilla && epatch ${FILESDIR}/swfdec-mozilla.patch

}

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

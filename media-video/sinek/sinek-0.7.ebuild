# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/sinek/sinek-0.7.ebuild,v 1.1 2002/07/24 03:57:46 agenkin Exp $

DESCRIPTION="GTK interface for xine"
HOMEPAGE="http://sinek.soureforge.net"
LICENSE="GPL"

DEPEND=">=media-libs/xine-lib-0.9.12
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nls? ( sys-devel/gettext )
	guile? ( dev-util/guile )"

SRC_URI="mirror://sourceforge/sinek/${P}.tar.gz"
S="${WORKDIR}/${P}"

src_compile(){
	local myconf
	
	use nls || myconf="${myconf} --disable-nls"
	use guile || myconf="${myconf} --disable-guile"
	
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		${myconf} || die
		
	emake || die
}

src_install(){
	make \
		prefix=${D}/usr \
		install || die
	
	if use gnome
	then
		insinto /usr/share/pixmaps
		doins pixmaps/${PN}.xpm
		insinto /usr/share/gnome/apps/Multimedia
		doins ${PN}.desktop
	fi
}

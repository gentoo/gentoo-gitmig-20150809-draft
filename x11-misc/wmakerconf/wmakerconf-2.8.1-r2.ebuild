# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/wmakerconf/wmakerconf-2.8.1-r2.ebuild,v 1.14 2003/06/04 13:44:40 joker Exp $

IUSE="nls gnome imlib perl"

S=${WORKDIR}/${P}
DESCRIPTION="X based config tool for the windowmaker X windowmanager."
SRC_URI="http://wmaker.orcon.net.nz/current/${P}.tar.gz"
HOMEPAGE="http://ulli.on.openave.net/wmakerconf/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

DEPEND="=x11-libs/gtk+-1.2*
	x11-wm/windowmaker 
	x11-libs/libPropList
	gnome? ( =gnome-base/gnome-libs-1.4* )
	imlib? ( media-libs/imlib )"
	

RDEPEND="nls? ( sys-devel/gettext )
	perl? ( dev-lang/perl
		net-misc/wget )"

src_compile() {

	local myconf

	use nls	|| myconf="${myconf} --disable-nls"

	use imlib || myconf="${myconf} --disable-imlibtest"
	
	use gnome || myconf="${myconf} --without-gnome"

	./configure \
		--prefix=/usr \
		--host=${CHOST} \
		--with-wmakerdataprefix=/usr/share \
		--sysconfdir=/etc \
		${myconf} || die
	emake || die

}

src_install() {
	
	make \
			prefix=${D}/usr \
			GNOMEDIR=${D}/usr/share/gnome/apps/Settings \
			install || die

	dodoc README MANUAL AUTHORS TODO COPYING ChangeLog
		dohtml -r .
}

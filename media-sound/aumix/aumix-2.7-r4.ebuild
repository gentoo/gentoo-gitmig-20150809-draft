# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.7-r4.ebuild,v 1.17 2003/06/20 13:07:55 gmsoft Exp $

DESCRIPTION="Aumix volume/mixer control program."
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.gz"
HOMEPAGE="http://jpj.net/~trevor/aumix/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa"
IUSE="gpm nls gtk gnome alsa"

DEPEND=">=sys-libs/ncurses-5.2
	gpm?  ( >=sys-libs/gpm-1.19.3 )
	alsa? ( >=media-libs/alsa-lib-0.5.10 )
	gtk?  ( =x11-libs/gtk+-1.2* )
	nls?  ( sys-devel/gettext )"

src_compile() {
	local myconf
	use gpm  || myconf="${myconf} --without-gpm"
	use nls  || myconf="${myconf} --disable-nls"
	use gtk  || myconf="${myconf} --without-gtk"
	use alsa || myconf="${myconf} --without-alsa"
	
	econf ${myconf}
	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
	
	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO
	
	if use gnome; then
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/aumix.desktop
		dodir /usr/share/pixmaps
		ln -s ../aumix/aumix.xpm ${D}/usr/share/pixmaps
	fi
	
	exeinto /etc/init.d ; newexe ${FILESDIR}/aumix.rc6 aumix
}

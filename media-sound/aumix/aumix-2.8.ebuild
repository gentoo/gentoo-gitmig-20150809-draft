# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.8.ebuild,v 1.5 2003/09/07 00:06:04 msterret Exp $

IUSE="gpm nls gtk gnome alsa gtk2"

DESCRIPTION="Aumix volume/mixer control program."
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.bz2"
HOMEPAGE="http://jpj.net/~trevor/aumix/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 hppa"

DEPEND=">=sys-libs/ncurses-5.2
	gpm?  ( >=sys-libs/gpm-1.19.3 )
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
	gtk?  ( =x11-libs/gtk+-1.2* )
	gtk2? ( >=x11-libs/gtk+-2.0.0 )
	nls?  ( sys-devel/gettext )"

src_compile() {
	local myconf

	if use gtk2; then
		myconf="${myconf} --without-gtk1"
	elif use gtk; then
		myconf="${myconf} --without-gtk"
	else
		myconf="${myconf} --without-gtk --without-gtk1";
	fi

	use gpm  || myconf="${myconf} --without-gpm"
	use nls  || myconf="${myconf} --disable-nls"
	use alsa || myconf="${myconf} --without-alsa"

	econf ${myconf}
	emake || die "make failed"
}

src_install() {
	einstall

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO

	if use gnome; then
		insinto /usr/share/gnome/apps/Multimedia
		doins ${FILESDIR}/aumix.desktop
		dodir /usr/share/pixmaps
		ln -s ../aumix/aumix.xpm ${D}/usr/share/pixmaps
	fi

	exeinto /etc/init.d ; newexe ${FILESDIR}/aumix.rc6 aumix
}

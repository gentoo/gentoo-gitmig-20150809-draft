# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.8.ebuild,v 1.14 2004/04/02 09:41:04 eradicator Exp $

IUSE="gtk gtk2 gnome gpm nls"

DESCRIPTION="Aumix volume/mixer control program."
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.bz2"
HOMEPAGE="http://jpj.net/~trevor/aumix/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 hppa amd64 sparc alpha ia64"

#alsa support is broken in 2.8	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
DEPEND=">=sys-libs/ncurses-5.2
	gpm?  ( >=sys-libs/gpm-1.19.3 )
	gtk?  (
			!gtk2? ( =x11-libs/gtk+-1.2* )
			gtk2? ( >=x11-libs/gtk+-2.0.0 )
	)
	nls?  ( sys-devel/gettext )"

src_compile() {
#	`use_with alsa`
	local myconf=`use_with gpm` `use_enable nls`

	if use gtk; then
		if use gtk2; then
			myconf="${myconf} --with-gtk --without-gtk1"
		else
			myconf="${myconf} --without-gtk --with-gtk1"
		fi
	else
		myconf="${myconf} --without-gtk --without-gtk1";
	fi

	econf ${myconf} || die
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

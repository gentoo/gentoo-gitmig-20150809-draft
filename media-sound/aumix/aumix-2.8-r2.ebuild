# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/aumix/aumix-2.8-r2.ebuild,v 1.2 2004/07/22 09:05:45 eradicator Exp $

IUSE="gtk gtk2 gpm nls"

inherit eutils

DESCRIPTION="Aumix volume/mixer control program."
SRC_URI="http://jpj.net/~trevor/aumix/${P}.tar.bz2"
HOMEPAGE="http://jpj.net/~trevor/aumix/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~hppa ~amd64 ~sparc ~alpha ~ia64 ~mips"

#alsa support is broken in 2.8	alsa? ( >=media-libs/alsa-lib-0.9.0_rc1 )
DEPEND=">=sys-libs/ncurses-5.2
	gpm?  ( >=sys-libs/gpm-1.19.3 )
	gtk?  (
			!gtk2? ( =x11-libs/gtk+-1.2* )
			gtk2? ( >=x11-libs/gtk+-2.0.0 )
	)
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-nohome.patch
	epatch ${FILESDIR}/${P}-close-dialogs.patch
	epatch ${FILESDIR}/${P}-save_load.patch
}

src_compile() {
#	`use_with alsa`

	# use_with borks becasue of bad configure script.
	if use gtk; then
		if use gtk2; then
			myconf="${myconf} --without-gtk1";
		else
			myconf="${myconf} --without-gtk";
		fi
	else
		myconf="${myconf} --without-gtk --without-gtk1";
	fi

	if ! use gpm; then
		myconf="${myconf} --without-gpm"
	fi

	econf ${myconf} || die
	emake || die "make failed"
}

src_install() {
	einstall

	dodoc AUTHORS BUGS COPYING ChangeLog NEWS README TODO

	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/aumix.desktop
	insinto /usr/share/applnk/Multimedia
	doins ${FILESDIR}/aumix.desktop
	insinto /usr/share/applications
	doins ${FILESDIR}/aumix.desktop

	dodir /usr/share/pixmaps
	ln -s ../aumix/aumix.xpm ${D}/usr/share/pixmaps

	exeinto /etc/init.d ; newexe ${FILESDIR}/aumix.rc6 aumix
}

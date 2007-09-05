# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/tea/tea-17.0.2.ebuild,v 1.2 2007/09/05 16:16:42 armin76 Exp $

inherit eutils

DESCRIPTION="Small, lightweight GTK+ text editor"
HOMEPAGE="http://tea-editor.sourceforge.net/"
SRC_URI="mirror://sourceforge/tea-editor/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ia64 x86 ~x86-fbsd"
IUSE="enchant gnome hacking ipv6 sounds spell"

RDEPEND="x11-libs/gtk+
	gnome? ( x11-libs/gtksourceview
		gnome-base/gnome-vfs )"
DEPEND="${RDEPEND}
	x11-libs/libX11
	sounds? ( media-libs/gstreamer )
	spell? ( app-text/aspell )
	enchant? ( app-text/enchant )
	dev-util/pkgconfig"

src_compile() {
	local myconf

	if use sounds; then
		myconf="${myconf} --enable-sounds"
	fi
	if use hacking; then
		myconf="${myconf} --enable-hacking"
	fi
	if ! use gnome; then
		myconf="${myconf} --enable-legacy"
	fi
	if use enchant; then
		myconf="${myconf} --enable-enchant"
	fi

	econf \
	$(use_enable ipv6) \
	${myconf} || die "econf failed!"

	emake || die "emake failed!"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed!"

	make_desktop_entry tea Tea /usr/share/tea/pixmaps/tea_icon_v2.png Development

#	insinto /usr/share/doc/tea/
#	doins AUTHORS COPYING NEWS README TODO ChangeLog doc/*

#	insinto /usr/share/pixmaps/
#	doins pixmaps/*
}

pkg_postinst() {
	if use spell ; then
		elog "To get full spellchecking functuality, ensure that you install"
		elog "the relevant language pack(s)"
	fi
}

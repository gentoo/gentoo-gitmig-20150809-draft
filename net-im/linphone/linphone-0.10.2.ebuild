# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linphone/linphone-0.10.2.ebuild,v 1.9 2004/01/03 02:10:56 stkn Exp $

IUSE="doc gnome gtk2 gtk nls xv alsa"

DESCRIPTION="Linphone is a Web phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://simon.morlat.free.fr/download/${PV}/sources/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="dev-libs/glib
	>=net-libs/libosip-0.9.6
	dev-util/pkgconfig
	x86? ( xv? ( dev-lang/nasm ) )
	gtk? ( =x11-libs/gtk+-1.2* )
	gtk2? ( >=x11-libs/gtk+-2 )
	gnome? ( gnome-base/gnome-panel
	gnome-base/libgnome
	gnome-base/libgnomeui )
	alsa? ( >media-libs/alsa-lib-0.5 )
	doc? ( dev-util/gtk-doc )"

src_compile() {

	local myconf

	if use gnome
	then
	    use gtk2 && myconf="${myconf} --enable-platform-gnome-2"
	else
	    use gnome || myconf="${myconf}--enable-gnome_ui=no"
	fi

	if use gtk && use doc
	then
		myconf="${myconf} --enable-gtk-doc"
	else
		myconf="${myconf} --disable-gtk-doc"
	fi

	econf \
		`use_enable alsa` \
		`use_enable nls` \
		${myconf} || die
	emake || die
}

src_install () {
	dodoc ABOUT-NLS COPYING README AUTHORS BUGS INSTALL NEWS ChangeLog TODO
	einstall PIXDESTDIR=${D} || die
}

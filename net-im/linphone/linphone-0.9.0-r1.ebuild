# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linphone/linphone-0.9.0-r1.ebuild,v 1.4 2003/12/06 23:29:17 lanius Exp $

IUSE="doc gtk nls xv alsa"

DESCRIPTION="Linphone is a Web phone with a GNOME interface."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://www.linphone.org/download/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="dev-libs/glib
	=net-libs/libosip-0.8.8
	=gnome-base/gnome-panel-1.4.1
	xv? ( dev-lang/nasm )
	gtk? ( =x11-libs/gtk+-1.2* )
	alsa? ( >media-libs/alsa-lib-0.5 )"

src_compile() {

	local myconf

	if use gtk && use doc
	then
		myconf="--enable-gtk-doc"
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

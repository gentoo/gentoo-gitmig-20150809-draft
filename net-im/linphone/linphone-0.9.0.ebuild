# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/linphone/linphone-0.9.0.ebuild,v 1.4 2003/03/20 14:00:12 seemant Exp $

IUSE="doc gtk nls xv alsa"

# AUTHOR: Paul Belt <gaarde@gentoo.org>

DESCRIPTION="Linphone is a Web phone with a GNOME interface. It let you make two-party calls over IP networks such as the Internet. It uses the IETF protocols SIP (Session Initiation Protocol) and RTP (Realtime Transport Protocol) to make calls, so it should be able to communicate with other SIP-based Web phones. With several codecs available, it can be used with high speed connections as well as 28k modems."
HOMEPAGE="http://www.linphone.org/?lang=us"
SRC_URI="http://www.linphone.org/download/${P}.tar.gz"

SLOT="1"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~mips ~hppa ~arm"

DEPEND="dev-libs/glib
	=net-libs/libosip-0.8.8
	=gnome-base/gnome-panel-1.4.1
	xv? ( dev-lang/nasm )
	gtk? ( =x11-libs/gtk-1.2* )
	alsa? ( >media-sound/alsa-driver-0.5 )"

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

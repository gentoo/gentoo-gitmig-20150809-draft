# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-2.70.ebuild,v 1.3 2004/12/02 15:23:32 chriswhite Exp $

inherit nsplugins toolchain-funcs

DESCRIPTION="mplayer plug-in for Mozilla"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk2"

DEPEND="
	>=media-video/mplayer-0.92
	net-libs/gecko-sdk
	gtk2? (
		>=x11-libs/gtk+-2.2.0
		dev-libs/atk
		>=dev-libs/glib-2.2.0
		>=x11-libs/pango-1.2.1 )
	!gtk2? (
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )"

S=${WORKDIR}/${PN}

src_compile() {
	local myconf
	myconf="${myconf} --with-gecko-sdk=/usr/share/gecko-sdk"
	if use gtk2; then
		einfo Configuring to build using gtk2
		myconf="${myconf} --enable-gtk2"
	else
		einfo Configuring to build using gtk1
		myconf="${myconf} --disable-gtk2 --enable-gtk1"
	fi
	econf ${myconf} || die
	emake || die
}

src_install() {
	exeinto /opt/netscape/plugins
	doexe mplayerplug-in.so
	inst_plugin /opt/netscape/plugins/mplayerplug-in.so

	insinto /etc
	doins mplayerplug-in.conf

	dodoc ChangeLog INSTALL README
}

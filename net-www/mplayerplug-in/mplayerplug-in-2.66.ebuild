# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-2.66.ebuild,v 1.4 2004/11/06 00:11:45 chriswhite Exp $

inherit nsplugins toolchain-funcs

S=${WORKDIR}/${PN}
GECKO_SDK="gecko-sdk-i686-pc-linux-gnu-1.6.tar.gz"

DESCRIPTION="mplayer plug-in for Mozilla"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	x86? ( ftp://ftp.mozilla.org/pub/mozilla.org/mozilla/releases/mozilla1.6/${GECKO_SDK} ) "
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"

KEYWORDS="~x86 ~amd64 ~ia64 ~ppc ~sparc ~alpha ~hppa ~mips"
SLOT="0"
LICENSE="GPL-2"
IUSE="gtk2"

DEPEND=">=media-video/mplayer-0.92
	gtk2? (
		>=x11-libs/gtk+-2.2.0
		dev-libs/atk
		>=dev-libs/glib-2.2.0
		>=x11-libs/pango-1.2.1 )
	!gtk2? (
		=x11-libs/gtk+-1.2*
		=dev-libs/glib-1.2* )"

src_compile() {
	local myconf
	use x86 && myconf="${myconf} --with-gecko-sdk=${WORKDIR}/gecko-sdk"
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

	dodoc ChangeLog INSTALL LICENSE README
}

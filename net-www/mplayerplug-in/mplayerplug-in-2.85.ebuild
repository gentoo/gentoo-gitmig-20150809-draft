# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-2.85.ebuild,v 1.4 2005/08/25 23:00:15 agriffis Exp $

inherit nsplugins toolchain-funcs multilib

DESCRIPTION="mplayer plug-in for Mozilla"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 -hppa ia64 ppc ~sparc ~x86"
IUSE="gtk2"

DEPEND="
	>=media-video/mplayer-1.0_pre5
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
	myconf="${myconf} --with-gecko-sdk=/usr/$(get_libdir)/gecko-sdk"
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
	doexe mplayerplug-in.so || die "plugin failed"
	inst_plugin /opt/netscape/plugins/mplayerplug-in.so

	# Install .xpt, bug #83162
	insinto /opt/netscape/plugins
	doins mplayerplug-in.xpt
	inst_plugin /opt/netscape/plugins/mplayerplug-in.xpt

	insinto /etc
	doins mplayerplug-in.conf

	dodoc ChangeLog INSTALL README TODO DOCS/tech/*.txt
}

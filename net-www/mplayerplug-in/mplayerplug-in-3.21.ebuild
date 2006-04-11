# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-3.21.ebuild,v 1.6 2006/04/11 22:00:26 gustavoz Exp $

inherit nsplugins multilib

DESCRIPTION="mplayer plug-in for Gecko based browsers"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 -hppa ia64 ppc sparc x86"
IUSE="gecko-sdk gtk"

DEPEND=">=media-video/mplayer-1.0_pre5
		gecko-sdk? ( net-libs/gecko-sdk )
		!gecko-sdk? ( || ( >=www-client/mozilla-1.6 www-client/mozilla-firefox ) )
		|| ( ( x11-libs/libXpm
				x11-proto/xextproto
			)
			virtual/x11
		)
		gtk? (
			>=x11-libs/gtk+-2.2.0
			dev-libs/atk
			>=dev-libs/glib-2.2.0
			>=x11-libs/pango-1.2.1
		)"

S=${WORKDIR}/${PN}

src_compile() {
	local myconf

	if use gecko-sdk; then
		myconf="${myconf} --with-gecko-sdk=/usr/$(get_libdir)/gecko-sdk"
	fi

	# We force gtk2 now because moz only compiles against gtk2
	if use gtk; then
		myconf="${myconf} --enable-gtk2"
	else
		ewarn "For playback controls, you must enable gtk support."
		myconf="${myconf} --enable-x"
	fi

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	exeinto /opt/netscape/plugins
	doexe mplayerplug-in.so || die "plugin failed"
	inst_plugin /opt/netscape/plugins/mplayerplug-in.so

	insinto /opt/netscape/plugins
	doins mplayerplug-in.xpt || die "xpt failed"
	inst_plugin /opt/netscape/plugins/mplayerplug-in.xpt

	PLUGINS="gmp rm qt wmp"

	for plugin in ${PLUGINS}; do
		### Install the plugin
		exeinto /opt/netscape/plugins
		doexe "mplayerplug-in-${plugin}.so" || die "plugin ${plugin} failed"
		inst_plugin "/opt/netscape/plugins/mplayerplug-in-${plugin}.so"
		### Install the xpt
		insinto /opt/netscape/plugins
	    doins "mplayerplug-in-${plugin}.xpt" || die "plugin ${plugin} xpt failed"
		inst_plugin "/opt/netscape/plugins/mplayerplug-in-${plugin}.xpt"
	done

	insinto /etc
	doins mplayerplug-in.conf

	dodoc ChangeLog INSTALL README DOCS/tech/*.txt
}

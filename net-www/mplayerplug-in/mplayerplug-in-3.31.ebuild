# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-3.31.ebuild,v 1.2 2006/08/30 02:43:59 josejx Exp $

inherit eutils multilib nsplugins

DESCRIPTION="mplayer plug-in for Gecko based browsers"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 -hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="gtk divx gmedia real quicktime wmp"

DEPEND=">=media-video/mplayer-1.0_pre5
		|| ( www-client/mozilla-firefox
				www-client/seamonkey
		)
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

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/3.30-fix-cflags.patch
}

src_compile() {
	local myconf

	# We force gtk2 now because moz only compiles against gtk2
	if use gtk; then
		myconf="${myconf} --enable-gtk2"
	else
		ewarn "For playback controls, you must enable gtk support."
		myconf="${myconf} --enable-x"
	fi

	# Media Playback Support (bug #145517)
	### Divx Enable/Disable
	if use divx; then
		myconf="${myconf} --enable-dvx"
	else
		myconf="${myconf} --disable-dvx"
	fi

	### Google Media Enable/Disable
	if use gmedia; then
		myconf="${myconf} --enable-gmp"
	else
		myconf="${myconf} --disable-gmp"
	fi

	### Real Media Enable/Disable
	if use real; then
		myconf="${myconf} --enable-rm"
	else
		myconf="${myconf} --disable-rm"
	fi

	### Quicktime Enable/Disable
	if use quicktime; then
		myconf="${myconf} --enable-qt"
	else
		myconf="${myconf} --disable-qt"
	fi

	### Windows Media Enable/Disable
	if use wmp; then
		myconf="${myconf} --enable-wmp"
	else
		myconf="${myconf} --disable-wmp"
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

	PLUGINS="gmp rm qt wmp dvx"

	for plugin in ${PLUGINS}; do
		if [ -e "mplayerplug-in-${plugin}.so" ]; then
			### Install the plugin
			exeinto /opt/netscape/plugins
			doexe "mplayerplug-in-${plugin}.so" || die "plugin ${plugin} failed"
			inst_plugin "/opt/netscape/plugins/mplayerplug-in-${plugin}.so"
			### Install the xpt
			insinto /opt/netscape/plugins
		    doins "mplayerplug-in-${plugin}.xpt" || die "plugin ${plugin} xpt failed"
			inst_plugin "/opt/netscape/plugins/mplayerplug-in-${plugin}.xpt"
		fi
	done

	insinto /etc
	doins mplayerplug-in.conf

	dodoc ChangeLog INSTALL README DOCS/tech/*.txt
}

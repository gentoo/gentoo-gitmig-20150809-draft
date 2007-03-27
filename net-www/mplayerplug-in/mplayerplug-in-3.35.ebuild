# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-3.35.ebuild,v 1.6 2007/03/27 14:49:01 armin76 Exp $

inherit eutils multilib nsplugins

DESCRIPTION="mplayer plug-in for Gecko based browsers"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 -hppa ia64 ppc sparc x86"
IUSE="gtk divx gmedia realmedia quicktime wmp"

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
		)
		dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/3.30-fix-cflags.patch
	epatch ${FILESDIR}/${PN}-gcc4.patch
	epatch ${FILESDIR}/${P}-X.patch
	epatch ${FILESDIR}/${P}-firefox.patch
	epatch ${FILESDIR}/${P}-seamonkey.patch
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
	econf \
		${myconf} \
		$(use_enable divx dvx) \
		$(use_enable gmedia gmp) \
		$(use_enable realmedia rm) \
		$(use_enable quicktime qt) \
		$(use_enable wmp) \
		|| die "econf failed"

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

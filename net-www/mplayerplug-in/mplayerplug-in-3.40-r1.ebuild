# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-3.40-r1.ebuild,v 1.4 2007/07/04 21:20:31 armin76 Exp $

inherit eutils multilib

DESCRIPTION="mplayer plug-in for Gecko based browsers"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 -hppa ppc sparc x86"
IUSE="gtk divx gmedia mplayer-bin realmedia quicktime wmp"

DEPEND="
		|| ( www-client/mozilla-firefox
				www-client/seamonkey
				www-client/epiphany
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
		mplayer-bin? ( media-video/mplayer-bin )
		!mplayer-bin? ( >=media-video/mplayer-1.0_pre5 )
		dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-cflags.patch
	epatch ${FILESDIR}/${PN}-gcc4.patch
	### Adds support for 32 bit binary mplayer on amd64
	if use mplayer-bin; then
		epatch ${FILESDIR}/${PN}-mplayer-bin.patch
	fi
	epatch ${FILESDIR}/${PN}-3.35-seamonkey.patch
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
	exeinto /usr/$(get_libdir)/nsbrowser/plugins
	doexe mplayerplug-in.so || die "plugin failed"

	insinto /usr/$(get_libdir)/nsbrowser/plugins
	doins mplayerplug-in.xpt || die "xpt failed"

	PLUGINS="gmp rm qt wmp dvx"

	for plugin in ${PLUGINS}; do
		if [ -e "mplayerplug-in-${plugin}.so" ]; then
			### Install the plugin
			exeinto /usr/$(get_libdir)/nsbrowser/plugins
			doexe "mplayerplug-in-${plugin}.so" || die "plugin ${plugin} failed"
			### Install the xpt
			insinto /usr/$(get_libdir)/nsbrowser/plugins
		    doins "mplayerplug-in-${plugin}.xpt" || die "plugin ${plugin} xpt failed"
		fi
	done

	insinto /etc
	doins mplayerplug-in.conf

	dodoc ChangeLog INSTALL README DOCS/tech/*.txt
}

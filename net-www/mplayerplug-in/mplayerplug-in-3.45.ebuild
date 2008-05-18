# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/mplayerplug-in/mplayerplug-in-3.45.ebuild,v 1.9 2008/05/18 13:31:14 drac Exp $

inherit eutils multilib

DESCRIPTION="mplayer plug-in for Gecko based browsers"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 -hppa ~ia64 ppc ppc64 sparc x86"
IUSE="gtk divx gmedia mplayer-bin nls realmedia quicktime wmp"

LANGS="da de en_US es fr hu it ja ko nb pl pt_BR nl ru se zh_CN"
for X in ${LANGS}; do IUSE="${IUSE} linguas_${X}"; done

RDEPEND="
		|| ( =www-client/mozilla-firefox-2*
				=www-client/seamonkey-1*
				=net-libs/xulrunner-1.8*
				www-client/epiphany
		)
		x11-libs/libXpm
		x11-proto/xextproto
		gtk? (
			>=x11-libs/gtk+-2.2.0
			dev-libs/atk
			>=dev-libs/glib-2.2.0
			>=x11-libs/pango-1.2.1
		)
		mplayer-bin? ( media-video/mplayer-bin )
		!mplayer-bin? ( >=media-video/mplayer-1.0_pre5 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack "${A}"
	cd "${S}"
	epatch "${FILESDIR}/${PN}-3.40-cflags.patch"
	epatch "${FILESDIR}/${PN}-gcc4.patch"
	### Adds support for 32 bit binary mplayer on amd64
	if use mplayer-bin; then
		epatch "${FILESDIR}/${PN}-mplayer-bin.patch"
	fi
	epatch "${FILESDIR}/${PN}-3.35-seamonkey.patch"
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

	if use nls; then
		local WANT_LANGS
		for X in ${LANGS}; do
			if use linguas_${X}; then
				WANT_LANGS="${WANT_LANGS} ${X}"
			fi
		done
		emake -C po LANGUAGES="${WANT_LANGS# }" DESTDIR="${D}" install \
			|| die "Translation installation failed"
	fi

	insinto /etc
	doins mplayerplug-in.conf

	dodoc ChangeLog INSTALL README DOCS/tech/*.txt
}

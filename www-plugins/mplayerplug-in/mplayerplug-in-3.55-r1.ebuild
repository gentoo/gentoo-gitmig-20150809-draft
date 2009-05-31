# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-plugins/mplayerplug-in/mplayerplug-in-3.55-r1.ebuild,v 1.2 2009/05/31 00:47:07 dirtyepic Exp $

inherit eutils multilib autotools flag-o-matic

DESCRIPTION="mplayer plug-in for Gecko based browsers"
HOMEPAGE="http://mplayerplug-in.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 -hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gtk divx firefox gmedia quicktime realmedia seamonkey wmp xulrunner"

LANGS="cs da de en_US es fr hu it ja ko nb nl pl pt_BR ru sk se tr wa zh_CN"
IUSE="${IUSE} $(printf 'linguas_%s ' ${LANGS})"

RDEPEND=">=media-video/mplayer-1.0_pre5
	xulrunner? ( net-libs/xulrunner )
	!xulrunner? ( firefox? ( www-client/mozilla-firefox ) )
	!xulrunner? ( !firefox? ( seamonkey? ( =www-client/seamonkey-1* ) ) )
	x11-libs/libXpm
	x11-proto/xextproto
	gtk? (
		>=x11-libs/gtk+-2.2.0
		dev-libs/atk
		>=dev-libs/glib-2.2.0
		>=x11-libs/pango-1.2.1
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

pkg_setup() {
	### Mozilla Firefox 3.0 doesn't install the pkg config files
	if has_version ">=www-client/mozilla-firefox-3.0" &&
		! built_with_use www-client/mozilla-firefox xulrunner; then
		die 'Firefox 3.0 must be built with USE="xulrunner"'
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-3.40-cflags.patch"
	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${PN}-xulrunner-config-in.patch"
	#epatch "${FILESDIR}/${PN}_xulrunner-1.9.patch"
	#epatch "${FILESDIR}/${PN}-3.50-seamonkey.patch"
	epatch "${FILESDIR}/${PN}-min-cache-size.patch"
	epatch "${FILESDIR}"/${P}-glibc210.patch
	eautoreconf
}

_src_compile() {
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
		"$@" \
		$(use_enable divx dvx) \
		$(use_enable gmedia gmp) \
		$(use_enable realmedia rm) \
		$(use_enable quicktime qt) \
		$(use_enable wmp) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_compile() {
	# Add -fno-strict-aliasing to ensure correct compilation
	append-flags -fno-strict-aliasing

	_src_compile
}

src_install() {
	PLUGINS="in in-gmp in-rm in-qt in-wmp in-dvx"
	plugindir="nsbrowser/plugins"

	exeinto /usr/$(get_libdir)/${plugindir}
	insinto /usr/$(get_libdir)/${plugindir}

	for plugin in ${PLUGINS}; do
		if [ -e "mplayerplug-${plugin}.so" ]; then
			doexe "mplayerplug-${plugin}.so" || die "plugin mplayerplug-${plugin} failed"
		    doins "mplayerplug-${plugin}.xpt" || die "plugin mplayerplug-${plugin} xpt failed"
		fi
	done

	insinto /etc
	doins mplayerplug-in.conf

	dodoc ChangeLog README
}

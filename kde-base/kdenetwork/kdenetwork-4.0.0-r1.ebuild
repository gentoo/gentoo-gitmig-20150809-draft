# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdenetwork/kdenetwork-4.0.0-r1.ebuild,v 1.1 2008/01/23 01:14:35 ingmar Exp $

EAPI="1"

inherit kde4-base

DESCRIPTION="KDE network applications: Kopete, KPPP, KGet,..."
HOMEPAGE="http://www.kde.org/"

KEYWORDS="~amd64 ~x86"
IUSE="+addbookmarks +alias +autoreplace +contactnotes debug gadu groupwise
+highlight +history htmlhandbook +jabber jpeg latex +msn +nowlistening oscar
+plasma ppp +privacy qq slp sms ssl +statistics testbed +texteffect +translator
+urlpicpreview vnc +webpresence winpopup yahoo zeroconf"
# telepathy is broken
LICENSE="GPL-2 LGPL-2"
RESTRICT="test"

# TODO: SMPPPD = (SuSE Meta PPP Daemon). No ebuild known.
# FIXME: x11-proto/xf86vidmodeproto is in fact an optional dep,
# but without a cmake switch. Hard dep for now, no clue what it enables though.

# IUSE="jingle -meanwhile messenger"
#		jingle and irc are disabled in the package
#		meanwhile hasn't been ported to kde4 yet
#		messenger is the new msn support protocol (it's not ready yet)

COMMONDEPEND="
	dev-libs/libpcre
	kde-base/qimageblitz
	x11-libs/libXScrnSaver
	gadu? ( dev-libs/openssl )
	groupwise? ( app-crypt/qca:2 )
	jabber? ( net-dns/libidn app-crypt/qca:2 )
	jpeg? ( media-libs/jpeg )
	plasma? ( || ( kde-base/kdebase:${SLOT}
			kde-base/plasma:${SLOT} ) )

	slp? ( net-libs/openslp x11-libs/libXdamage )
	statistics? ( dev-db/sqlite:3 )
	vnc? ( >=net-libs/libvncserver-0.9 )
	webpresence? ( dev-libs/libxml2 dev-libs/libxslt )
	zeroconf? ( || ( net-dns/avahi net-misc/mDNSResponder ) )
"
#	telepathy? ( net-libs/decibel )

DEPEND="${COMMON_DEPEND}
	x11-proto/scrnsaverproto"

RDEPEND="${COMMON_DEPEND}
	ppp? ( net-dialup/ppp )
	ssl? ( dev-perl/IO-Socket-SSL )
"

pkg_setup() {
	if use zeroconf && has_version net-dns/avahi; then
		KDE4_BUILT_WITH_USE_CHECK="
			${KDE4_BUILT_WITH_USE_CHECK} net-dns/avahi mdnsresponder-compat"
	fi

	kde4-base_pkg_setup
}

src_compile() {
	# Translated Category fields cause protocols not appearing, bug 206877.
	sed -e '/X-KDE-PluginInfo-Category\[.*/d' \
		-i "${S}"/kopete/protocols/*/kopete_*.desktop || die "Sed failed."

	# kdenetwork looks for 'xmms' which isn't in the official portage tree.
	# I've disabled this check to prevent linking to user-installed things.
	mycmakeargs="${mycmakeargs}
		-DWITH_telepathy=OFF
		-DWITH_Xmms=OFF
		$(cmake-utils_use_with addbookmarks)
		$(cmake-utils_use_with alias)
		$(cmake-utils_use_with autoreplace)
		$(cmake-utils_use_with contactnotes)
		$(cmake-utils_use_with gadu OPENSSL)
		$(cmake-utils_use_with groupwise)
		$(cmake-utils_use_with groupwise QCA2)
		$(cmake-utils_use_with highlight)
		$(cmake-utils_use_with history)
		$(cmake-utils_use_with jabber IDN)
		$(cmake-utils_use_with jabber QCA2)
		$(cmake-utils_use_with jpeg JPEG)
		$(cmake-utils_use_with latex)
		$(cmake-utils_use_with msn)
		$(cmake-utils_use_with plasma Plasma)
		$(cmake-utils_use_with nowlistening)
		$(cmake-utils_use_with oscar)
		$(use ppp && echo -DBUILD_kppp=TRUE || echo -DBUILD_kppp=FALSE)
		$(cmake-utils_use_with privacy)
		$(cmake-utils_use_with qq)
		$(cmake-utils_use_with slp LibVNCServer)
		$(cmake-utils_use_with slp SLP)
		$(cmake-utils_use_with sms)
		$(cmake-utils_use_with statistics Sqlite)
		$(cmake-utils_use_with statistics)
		$(cmake-utils_use_with testbed)
		$(cmake-utils_use_with texteffect)
		$(cmake-utils_use_with translator)
		$(cmake-utils_use_with urlpicpreview)
		$(cmake-utils_use_with vnc LibVNCServer)
		$(cmake-utils_use_with webpresence LibXml2)
		$(cmake-utils_use_with webpresence LibXslt)
		$(cmake-utils_use_with webpresence)
		$(cmake-utils_use_with winpopup)
		$(cmake-utils_use_with yahoo)
		$(cmake-utils_use_with zeroconf DNSSD)
	"
	#	$(cmake-utils_use_with messenger)
	#	$(cmake-utils_use_with telepathy)
	#	$(cmake-utils_use_with telepathy Decibel)

	kde4-base_src_compile
}

pkg_postinst() {
	kde4-base_pkg_postinst

	#if use telepathy; then
	#	elog "To use kopete telepathy plugins, you need to start gabble first:"
	#	elog "GABBLE_PERSIST=1 telepathy-gabble &"
	#	elog "export TELEPATHY_DATA_PATH=/usr/share/telepathy/managers/"
	#fi

	if use jabber; then
		elog "In order to use ssl in jabber, messenger and irc you'll need to have qca-ossl"
	fi

	echo
	elog "If you want to use the remote desktop protocol (RDP) in krdc install >=net-misc/rdesktop-1.4.1"
	echo
}

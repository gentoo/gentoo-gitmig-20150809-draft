# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-voip/ekiga/ekiga-3.2.4.ebuild,v 1.1 2009/07/03 11:36:47 volkmar Exp $

EAPI="2"

KDE_REQUIRED="optional"

inherit eutils kde4-base gnome2
# gnome2 at the end to make it default

DESCRIPTION="H.323 and SIP VoIP softphone"
HOMEPAGE="http://www.ekiga.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="avahi dbus debug doc eds gconf gnome gstreamer +h323 kde kontact ldap
libnotify mmx nls +shm +sip static v4l xcap xv"

RDEPEND=">=dev-libs/glib-2.8.0:2
	dev-libs/libsigc++:2
	dev-libs/libxml2:2
	>=net-libs/opal-3.6.2[audio,sip,video,debug=,h323?]
	>=net-libs/ptlib-2.6.2[stun,video,wav,debug=]
	>=x11-libs/gtk+-2.12.0:2
	avahi? ( >=net-dns/avahi-0.6[dbus] )
	dbus? ( >=sys-apps/dbus-0.36
		>=dev-libs/dbus-glib-0.36 )
	eds? ( >=gnome-extra/evolution-data-server-1.2 )
	gconf? ( >=gnome-base/gconf-2.6.0:2 )
	gnome? ( || ( >=x11-libs/gtk+-2.14:2
		( >=gnome-base/libgnome-2.14.0
		>=gnome-base/libgnomeui-2.14.0 ) ) )
	gstreamer? ( >=media-libs/gst-plugins-base-0.10.21.3:0.10 )
	kde? ( >=kde-base/kdelibs-${KDE_MINIMAL}
		x11-libs/qt-core:4
		kontact? ( >=kde-base/kdepimlibs-${KDE_MINIMAL} ) )
	ldap? ( dev-libs/cyrus-sasl:2
		net-nds/openldap )
	libnotify? ( x11-libs/libnotify
		debug? ( >=x11-libs/libnotify-0.4.5 ) )
	shm? ( x11-libs/libXext )
	xcap? ( net-libs/libsoup:2.4 )
	xv? ( x11-libs/libXv )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	>=dev-util/pkgconfig-0.20
	sys-devel/gettext
	doc? ( app-text/scrollkeeper
		app-text/gnome-doc-utils )
	v4l? ( sys-kernel/linux-headers )"

DOC_LINGUAS="bg ca de el en_GB es eu fi fr oc pt_BR ru sv uk"
IUSE_LINGUAS="${DOC_LINGUAS} am ar as az be bg bn_IN bn bs ca crh cs cy da de dz
el en_CA en_GB eo es et eu fa fi fr ga gl gu he hi hr hu id is it ja ka kn ko ku
lt lv mai mk ml mn mr ms nb ne nl nn oc or pa pl pt_BR pt ro ru rw si sk sl sq
sr@latin sr sv ta te th tr uk vi wa xh zh_CN zh_HK zh_TW"

for l in ${IUSE_LINGUAS}; do
	IUSE="${IUSE} linguas_${l}"
done

DOCS="AUTHORS ChangeLog FAQ MAINTAINERS NEWS README TODO"

# debug is managed by the ebuild
GCONF_DEBUG="no"

# NOTES:
# having >=gtk+-2.14 is actually removing need of +gnome but it's clearer to
# 	represent it with || in gnome dep
# TODO: gnome2 eclass add --[dis|en]able-gtk-doc wich throws a QA warning
#	a patch has been submitted, see bug 262491
# ptlib/opal needed features are not checked by ekiga, upstream bug 577249
# opal[sip] should be opal[sip?], upstream bug 577248
# libnotify-0.4.4 bug with +debug, upstream bug 583719
# doc is not installing dev doc (doxygen)

# TODO:
# if really want to use ked4-base, should use COMMONDEPEND

# UPSTREAM:
# contact ekiga team to be sure intltool and gettext are not nls deps

pkg_setup() {
	if use kde; then
		kde4-base_pkg_setup
	fi

	if ! use h323 && ! use sip; then
		eerror "You have disabled h323 and sip USE flags."
		eerror "At least one of these USE flags needs to be enabled."
		eerror "Please, enable h323 and/or sip and re-emerge ${PN}."
		die "At least sip or h323 need to be enabled."
	fi

	if use kontact && ! use kde; then
		eerror "To enable kontact USE flag, you need kde USE flag to be enabled"
		eerror "Please, enable kde or disable kontact and re-emerge ${PN}."
		die "You need to enable kde or disable kontact."
	fi

	strip-linguas ${IUSE_LINGUAS}

	if [[ -z "${LINGUAS}" ]]; then
		# no linguas set, using the default one
		LINGUAS=" "
	fi

	# update scrollkeeper database if doc has been enabled
	if use doc; then
		SCROLLKEEPER_UPDATE=1
	else
		SCROLLKEEPER_UPDATE=0
	fi

	# dbus-service: always enable if dbus is enabled, no reason to disable it
	# scrollkeeper: updates scrollkeeper database
	# schemas-install: install gconf schemas
	G2CONF="${G2CONF}
		--disable-dependency-tracking
		--disable-maintainer-mode
		--enable-libtool-lock
		$(use_enable avahi)
		$(use_enable dbus)
		$(use_enable dbus dbus_service)
		$(use_enable debug gtk-debug)
		$(use_enable debug opal-debug)
		$(use_enable doc gdu)
		$(use_enable doc scrollkeeper)
		$(use_enable eds)
		$(use_enable gconf)
		$(use_enable gconf schemas-install)
		$(use_enable gnome)
		$(use_enable gstreamer)
		$(use_enable kde)
		$(use_enable kontact kab)
		$(use_enable ldap)
		$(use_enable libnotify notify)
		$(use_enable mmx)
		$(use_enable nls)
		$(use_enable shm)
		$(use_enable static static-libs)
		$(use_enable xcap)
		$(use_enable xv)"
}

src_prepare() {
	gnome2_src_prepare

	epatch "${FILESDIR}"/${P}-gtk+-2.12-fix.patch

	# remove call to gconftool-2 --shutdown, upstream bug 555976
	# gnome-2 eclass is reloading schemas with SIGHUP
	sed -i -e '/gconftool-2 --shutdown/d' Makefile.in \
		|| die "patching Makefile.in failed"

	# SIP is automatically enabled with opal[sip], want it to be a user choice
	# upstream bug 575832
	if ! use sip; then
		sed -i -e "s/SIP=\"yes\"/SIP=\"no\"/" configure \
			|| die "patching configure failed"
		sed -i -e \
			"s:SIP=\`\$PKG_CONFIG --variable=OPAL_SIP opal\`:SIP=\"no\":" \
			configure || die "patching configure failed"
	fi

	# H323 is automatically enabled with opal[h323], want it to be a user choice
	# upstream bug 575833
	if ! use h323; then
		sed -i -e "s/H323=\"yes\"/H323=\"no\"/" configure \
			|| die "patching configure failed"
		sed -i -e \
			"s:H323=\`\$PKG_CONFIG --variable=OPAL_H323 opal\`:H323=\"no\":" \
			configure || die "patching configure failed"
	fi

	# V4L support is auto-enabled, want it to be a user choice
	# do not contact upstream because that's a hack
	# TODO: check if upstream has removed this hack
	if ! use v4l; then
		sed -i -e "s/V4L=\"enabled\"/V4L=\"disabled\"/" configure \
			|| die "patching configure failed"
	fi
}

src_test() {
	# must be explicit because kde4-base in exporting a src_test function
	emake -j1 check || die "emake check failed"
}

src_install() {
	gnome2_src_install

	if use doc && use dbus; then
		insinto "/usr/share/doc/${PF}/"
		doins doc/using_dbus.html || die "doins failed"
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use kde; then
		kde4-base_pkg_postinst
	fi

	if ! use gnome; then
		ewarn "USE=-gnome is experimental, weirdness with UI and config keys can appear."
	fi

	if use gstreamer || use kde || use xcap || use kontact; then
		ewarn "You have enabled gstreamer, kde, xcap or kontact USE flags."
		ewarn "Those USE flags are considered experimental features."
	fi
}

pkg_postrm() {
	gnome2_pkg_postrm

	if use kde; then
		kde4-base_pkg_postrm
	fi
}

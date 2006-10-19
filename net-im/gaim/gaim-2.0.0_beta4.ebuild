# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-2.0.0_beta4.ebuild,v 1.1 2006/10/19 22:08:35 gothgirl Exp $

inherit flag-o-matic eutils toolchain-funcs debug multilib mono autotools perl-app gnome2

MY_PV=${P/_beta/beta}
#MY_PV="2.0.0beta3.1"
#MY_P="${PN}-${MY_PV}"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim/${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="avahi audiofile bonjour cjk crypt dbus debug doc eds gadu gnutls meanwhile mono nas nls perl silc spell startup-notification tcl tk xscreensaver custom-flags ssl qq msn"

RDEPEND="
	audiofile? ( media-libs/libao
		media-libs/audiofile )
	bonjour? ( !avahi? ( net-misc/howl )
		   avahi? ( net-dns/avahi ) )
	dbus? ( >=sys-apps/dbus-0.35
		>=dev-lang/python-2.4 )
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	perl? ( >=dev-lang/perl-5.8.2-r1 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	gadu?  ( net-libs/libgadu )
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( >=dev-libs/nss-3.11 )
	)
	msn? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( >=dev-libs/nss-3.11 )
	)
	meanwhile? ( net-libs/meanwhile )
	silc? ( >=net-im/silc-toolkit-0.9.12-r3 )
	eds? ( gnome-extra/evolution-data-server )
	tcl? ( dev-lang/tcl )
	tk? ( dev-lang/tk )
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	mono? ( dev-lang/mono )
	doc? ( app-doc/doxygen )
	xscreensaver? (	x11-libs/libXScrnSaver )
	dev-libs/libxml2"

DEPEND="$RDEPEND
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

PDEPEND="crypt? ( >=x11-plugins/gaim-encryption-3.0_beta5 )"

S="${WORKDIR}/${MY_PV}"

# Enable Default protocols
DYNAMIC_PRPLS="irc,jabber,msn,oscar,yahoo,zephyr,simple"

# List of plugins
#   app-accessibility/festival-gaim
#   net-im/gaim-blogger
#   net-im/gaim-bnet
#   net-im/gaim-meanwhile
#   net-im/gaim-snpp
#   x11-plugins/autoprofile
#   x11-plugins/gaim-assistant
#   x11-plugins/gaim-encryption
#   x11-plugins/gaim-extprefs
#   x11-plugins/gaim-latex
#   x11-plugins/gaim-otr
#   x11-plugins/gaim-rhythmbox
#   x11-plugins/gaim-xmms-remote
#   x11-plugins/gaimosd
#   x11-plugins/guifications


print_gaim_warning() {
	ewarn
	ewarn "This is a beta release!  Please back up everything in your .gaim"
	ewarn "directory. We're looking for lots of feedback on this release"
	ewarn "especially what you love about it and what you hate about it."
	ewarn
	ewarn "If you are merging ${MY_P} from an earlier version, you may need"
	ewarn "to re-merge any plugins like gaim-encryption or gaim-snpp."
	ewarn
	ewarn "If you experience problems with gaim, file them as bugs with"
	ewarn "Gentoo's bugzilla, http://bugs.gentoo.org.  DO NOT report them"
	ewarn "as bugs with gaim's sourceforge tracker, and by all means DO NOT"
	ewarn "seek help in #gaim."
	ewarn
	ewarn "Be sure to USE=\"debug\" and include a backtrace for any seg"
	ewarn "faults, see http://gaim.sourceforge.net/gdb.php for details on"
	ewarn "backtraces."
	ewarn
	ewarn "Please read the gaim FAQ at http://gaim.sourceforge.net/faq.php"
	ewarn
	einfo
	if  use custom-flags; then
		einfo "Note that you have chosen NOT TO FILTER UNSTABLE C[XX]FLAGS."
		einfo "DO NOT file bugs with GENTOO or UPSTREAM while using custom-flags"
		einfo
	else
		einfo "Note that we are now filtering all unstable flags in C[XX]FLAGS."
		einfo
	fi

	if use silc; then
		einfo "To be able to connect to silc network, you need to run"
		einfo "\`usermod -c \"comment\"\` as user as which you are running gaim,"
		einfo "where \"comment\" is either your real name if you want show it"
		einfo "on silc or any othe not empty string."
		einfo
	fi
	ebeep 5
	epause 3
}

pkg_setup() {
	print_gaim_warning

	if use bonjour && use avahi && ! built_with_use net-dns/avahi howl-compat ; then
	eerror
	eerror You need to rebuild net-dns/avahi with USE=howl-compat in order
	eerror to enable howl support for the bonjour protocol in gaim.
	eerror
	die "Configure failed"
	fi

	if use gadu && built_with_use net-libs/libgadu ssl ; then
	eerror
	eerror You need to rebuild net-libs/libgadu with USE=-ssl in order
	eerror enable gadu gadu support in gaim.
	eerror
	die "Configure failed"
	fi
}

src_unpack() {
	gnome2_src_unpack
	epatch "${FILESDIR}"/"${P}"-dbus.patch
}

src_compile() {
	# Stabilize things, for your own good
	if ! use custom-flags; then
		strip-flags
	fi
	replace-flags -O? -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf

	if use gadu; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},gg"
	fi

	if use silc; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},silc"
	fi

	if use qq; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},qq"
	fi

	if use meanwhile; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},sametime"
	fi

	if use bounjour; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},bonjour"
	fi


	if use ssl || use msn ; then
		if use gnutls ; then
			einfo "Disabling NSS, using GnuTLS"
			myconf="${myconf} --enable-nss=no --enable-gnutls=yes"
			myconf="${myconf} --with-gnutls-includes=/usr/include/gnutls"
			myconf="${myconf} --with-gnutls-libs=/usr/$(get_libdir)"
		else
			einfo "Disabling GnuTLS, using NSS"
			myconf="${myconf} --enable-gnutls=no --enable-nss=yes"
		fi
	else
		einfo "No SSL support selected"
		myconf="${myconf} --enable-gnutls=no --enable-nss=no"
	fi

	if use xscreensaver ; then
			myconf="${myconf} --x-includes=/usr/include/X11"
	fi

	G2CONF=" \
		$(use_enable nls) \
		$(use_enable perl) \
		$(use_enable spell gtkspell) \
		$(use_enable startup-notification) \
		$(use_enable tcl) \
		$(use_enable tk) \
		$(use_enable mono) \
		$(use_enable debug) \
		$(use_enable dbus) \
		$(use_enable meanwhile) \
		$(use_enable nas) \
		$(use_enable eds gevolution) \
		$(use_enable audiofile audio) \
		$(use_enable doc doxygen) \
		"--with-dynamic-prpls=${DYNAMIC_PRPLS}" \
		${myconf} " || die "Configuration failed"

	gnome2_src_compile || die "Make failed"
}

src_install() {
	gnome2_src_install || die "Install failed"
	use perl && fixlocalpod
	dodoc AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog
}

pkg_postinst() {
	gnome2_gconf_install
	print_gaim_warning
}

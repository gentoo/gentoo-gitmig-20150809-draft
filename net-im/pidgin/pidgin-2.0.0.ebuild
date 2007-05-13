# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/pidgin/pidgin-2.0.0.ebuild,v 1.2 2007/05/13 21:27:42 drizzt Exp $

inherit flag-o-matic eutils toolchain-funcs multilib autotools perl-app gnome2

MY_PV=${P/_beta/beta}

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://pidgin.im/"
SRC_URI="mirror://sourceforge/${PN}/${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="avahi bonjour cjk crypt dbus debug doc eds gadu gnutls gstreamer meanwhile nls perl silc startup-notification tcl tk xscreensaver custom-cflags spell ssl qq msn gadu"
IUSE="${IUSE} gtk sasl console groupwise prediction" # mono"

RDEPEND="
	bonjour? ( !avahi? ( net-misc/howl )
		   avahi? ( net-dns/avahi ) )
	dbus? ( >=dev-libs/dbus-glib-0.71
		>=dev-python/dbus-python-0.71
		>=sys-apps/dbus-0.90
		>=dev-lang/python-2.4 )
	gtk? (
		spell? ( >=app-text/gtkspell-2.0.2 )
		>=x11-libs/gtk+-2.0
		startup-notification? ( >=x11-libs/startup-notification-0.5 )
		xscreensaver? (	x11-libs/libXScrnSaver )
		eds? ( gnome-extra/evolution-data-server ) 	)
	>=dev-libs/glib-2.0
	gstreamer? ( media-libs/gstreamer
		     media-libs/gst-plugins-good )
	perl? ( >=dev-lang/perl-5.8.2-r1 )
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
	tcl? ( dev-lang/tcl )
	tk? ( dev-lang/tk )
	gstreamer? ( >=media-libs/gstreamer-0.10 )
	sasl? ( >=dev-libs/cyrus-sasl-2 )
	doc? ( app-doc/doxygen )
	dev-libs/libxml2
	prediction? ( =dev-db/sqlite-3.3* )"
	#mono? ( dev-lang/mono )"

DEPEND="$RDEPEND
	dev-lang/perl
	dev-perl/XML-Parser
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

# PDEPEND="crypt? ( >=x11-plugins/gaim-encryption-3.0_beta5 )"

S="${WORKDIR}/${MY_PV}"

# Enable Default protocols
DYNAMIC_PRPLS="irc,jabber,oscar,yahoo,zephyr,simple"

# List of plugins yet to be ported (will be removed at some point)
#   app-accessibility/festival-gaim
#   net-im/gaim-blogger
#   net-im/gaim-bnet
#   net-im/gaim-meanwhile (integrated in gaim)
#   net-im/gaim-snpp (will soon be net-im/pidgin-snpp)
#   x11-plugins/autoprofile
#   x11-plugins/gaim-assistant
#   x11-plugins/gaim-encryption
#   x11-plugins/gaim-latex
#   x11-plugins/gaim-otr
#   x11-plugins/gaimosd
#   x11-plugins/gaim-xfire

# List of plugins
#   x11-plugins/pidgin-extprefs
#   x11-plugins/gaim-rhythmbox
#   x11-plugins/guifications


print_pidgin_warning() {
	ewarn
	ewarn "We strongly recommend that you backup your ~/.gaim directory"
	ewarn "before running Pidgin for the first time. Things you should be"
	ewarn "on the lookout for include problems with preferences being lost"
	ewarn "or forgotten, buddy icons not working as you expect, plugins or"
	ewarn "other external files not properly being found."
	ewarn
	ewarn "If you are merging ${MY_P} from an earlier version of gaim,"
	ewarn "you may need to re-merge any plugins like gaim-encryption or"
	ewarn " gaim-snpp (when they are ported to pidgin!)."
	ewarn
	ewarn "If you experience problems with pidgin, file them as bugs with"
	ewarn "Gentoo's bugzilla, http://bugs.gentoo.org.  DO NOT report them"
	ewarn "as bugs with pidgin's bug tracker, and by all means DO NOT"
	ewarn "seek help in #pidgin."
	ewarn
	ewarn "Be sure to USE=\"debug\" and include a backtrace for any seg"
	ewarn "faults, see http://developer.pidgin.im/wiki/GetABacktrace for details on"
	ewarn "backtraces."
	ewarn
	ewarn "Please read the pidgin FAQ at http://developer.pidgin.im/wiki/FAQ"
	ewarn
	einfo
	if  use custom-cflags; then
		einfo "Note that you have chosen NOT TO FILTER UNSTABLE C[XX]FLAGS."
		einfo "DO NOT file bugs with GENTOO or UPSTREAM while using custom-cflags"
		einfo
	else
		einfo "Note that we are now filtering all unstable flags in C[XX]FLAGS."
		einfo
	fi
}

pkg_setup() {
	print_pidgin_warning

	if use bonjour && use avahi && ! built_with_use net-dns/avahi howl-compat ; then
	eerror
	eerror "You need to rebuild net-dns/avahi with USE=howl-compat in order"
	eerror  "to enable howl support for the bonjour protocol in pidgin."
	eerror
	die "Configure failed"
	fi

	if use gadu && built_with_use net-libs/libgadu ssl ; then
	eerror
	eerror "You need to rebuild net-libs/libgadu with USE=-ssl in order"
	eerror "enable gadu gadu support in pidgin."
	eerror
	die "Configure failed"
	fi

	if use console &&  ! built_with_use sys-libs/ncurses unicode; then
		eerror
		eerror "You need to rebuild sys-libs/ncurses with USE=unicode in order"
		eerror "to build finch the console client of pidgin."
		eerror
		die "Configure failed"
	fi

	if ! use gtk && ! use console; then
		einfo
		elog "As you did not pick gtk or console use flag, building"
		elog "console only."
		einfo
	fi
}

src_compile() {
	# Stabilize things, for your own good
	if ! use custom-cflags; then
		strip-flags
	fi
	replace-flags -O? -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf

	if use gadu; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},gg"
			myconf="${myconf} --with-gadu-includes=."
			myconf="${myconf} --with-gadu-libs=."
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

	if use bonjour; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},bonjour"
	fi

	if use msn; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},msn"
	fi

	if use groupwise; then
		DYNAMIC_PRPLS="${DYNAMIC_PRPLS},novell"
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

	if ! use console && ! use gtk; then
		myconf="${myconf} --enable-consoleui"
	else
		myconf="${myconf} $(use_enable console consoleui) $(use_enable gtk gtkui)"
	fi

	econf \
		$(use_enable nls) \
		$(use_enable perl) \
		$(use_enable startup-notification) \
		$(use_enable tcl) \
		$(use_enable gtk sm) \
		$(use_enable spell gtkspell) \
		$(use_enable tk) \
		$(use_enable xscreensaver screensaver) \
		$(use_enable debug) \
		$(use_enable dbus) \
		$(use_enable meanwhile) \
		$(use_enable eds gevolution) \
		$(use_enable gstreamer) \
		$(use_enable sasl cyrus-sasl ) \
		$(use_enable doc doxygen) \
		$(use_enable prediction cap) \
		"--with-dynamic-prpls=${DYNAMIC_PRPLS}" \
		--disable-mono \
		${myconf} || die "Configuration failed"
		#$(use_enable mono) \
}

src_install() {
	gnome2_src_install
	use perl && fixlocalpod
	dodoc AUTHORS COPYING HACKING INSTALL NEWS README ChangeLog
}

pkg_postinst() {
	gnome2_pkg_postinst
	print_pidgin_warning
}

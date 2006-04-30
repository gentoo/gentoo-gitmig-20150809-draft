# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/gaim/gaim-2.0.0_beta3.ebuild,v 1.4 2006/04/30 02:26:54 anarchy Exp $

inherit flag-o-matic eutils toolchain-funcs debug multilib mono

MY_PV=${PV/_beta/beta}
MY_P="${PN}-${MY_PV}"

DESCRIPTION="GTK Instant Messenger client"
HOMEPAGE="http://gaim.sourceforge.net/"
SRC_URI="mirror://sourceforge/gaim/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="ao bonjour cjk dbus debug eds gnutls krb4 mono nas nls perl silc spell startup-notification tcltk xscreensaver"

RDEPEND="
	ao? ( media-libs/libao
		media-libs/audiofile )
	bonjour? ( net-misc/howl )
	dbus? ( >=sys-apps/dbus-0.35
		>=dev-lang/python-2.4 )
	>=x11-libs/gtk+-2.0
	>=dev-libs/glib-2.0
	nas? ( >=media-libs/nas-1.4.1-r1 )
	perl? ( >=dev-lang/perl-5.8.2-r1
		!<perl-core/ExtUtils-MakeMaker-6.17 )
	spell? ( >=app-text/gtkspell-2.0.2 )
	gnutls? ( net-libs/gnutls )
	!gnutls? ( >=dev-libs/nss-3.11
		>=dev-libs/nspr-4.6.1 )
	silc? ( >=net-im/silc-toolkit-0.9.12-r3 )
	eds? ( gnome-extra/evolution-data-server )
	krb4? ( >=app-crypt/mit-krb5-1.3.6-r1 )
	tcltk? ( dev-lang/tcl
		dev-lang/tk )
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	mono? ( dev-lang/mono )
	xscreensaver? ( x11-misc/xscreensaver )"

DEPEND="$RDEPEND
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

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
	ewarn "Again, this is a beta release and should not be used by those"
	ewarn "with a heart condition, if you are pregnant, or if you are under"
	ewarn "the age of 8. Side-effects include awesomeness, dumbfoundedness,"
	ewarn "dry mouth and lava. Consult your doctor to find out if"
	ewarn "${MY_P} is right for you."
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
	einfo "Note that we are now filtering all unstable flags in C[XX]FLAGS."
	einfo
	ebeep 5
	epause 3
}

pkg_setup() {
	print_gaim_warning
	if use krb4 && ! built_with_use app-crypt/mit-krb5 krb4 ; then
	eerror
	eerror You need to rebuild app-crypt/mit-krb5 with USE=krb4 in order to
	eerror enable krb4 support for the zephyr protocol in gaim.
	eerror
	die "Configure failed"
	fi
}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch ${FILESDIR}/${PN}-2.0.0-as-needed.patch
}

src_compile() {
	# Stabilize things, for your own good
	strip-flags
	replace-flags -O? -O2

	# -msse2 doesn't play nice on gcc 3.2
	[ "`gcc-version`" == "3.2" ] && filter-flags -msse2

	local myconf
	use ao || use audiofile || myconf="${myconf} --disable-audio"
	if ! use bonjour ; then
		myconf="${myconf} --with-howl-includes=."
		myconf="${myconf} --with-howl-libs=."
	fi
	use dbus && myconf="${myconf} --enable-dbus" || myconf="${myconf} --disable-dbus"
	use debug && myconf="${myconf} --enable-debug"
	use eds || myconf="${myconf} --disable-gevolution"
	use krb4 && myconf="${myconf} --with-krb4"
	use mono && myconf="${myconf} --enable-mono"
	use nas && myconf="${myconf} --enable-nas" || myconf="${myconf} --disable-nas"
	use nls  || myconf="${myconf} --disable-nls"
	use perl || myconf="${myconf} --disable-perl"
	if use ! silc ; then
		myconf="${myconf} --with-silc-includes=."
		myconf="${myconf} --with-silc-libs=."
	fi
	use spell || myconf="${myconf} --disable-gtkspell"
	use startup-notification || myconf="${myconf} --disable-startup-notification"
	use tcltk || myconf="${myconf} --disable-tcl --disable-tk"
	use xscreensaver || myconf="${myconf} --disable-screensaver"

	if use gnutls ; then
		einfo "Disabling NSS, using GnuTLS"
		myconf="${myconf} --enable-nss=no"
		myconf="${myconf} --with-gnutls-includes=/usr/include/gnutls"
		myconf="${myconf} --with-gnutls-libs=/usr/$(get_libdir)"
	else
		einfo "Disabling GnuTLS, using NSS"
		myconf="${myconf} --enable-gnutls=no"
	fi

	econf ${myconf} || die "Configuration failed"

	emake -j1 || die "Make failed"
}

src_install() {
	make install DESTDIR=${D} || die "Install failed"
	dodoc ABOUT-NLS AUTHORS COPYING HACKING INSTALL NEWS PROGRAMMING_NOTES README ChangeLog VERSION
}

pkg_postinst() {
	print_gaim_warning
}

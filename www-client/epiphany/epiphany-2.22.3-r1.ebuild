# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-2.22.3-r1.ebuild,v 1.6 2009/01/07 21:48:03 armin76 Exp $

inherit gnome2 eutils multilib

DESCRIPTION="GNOME webbrowser based on the mozilla rendering engine"
HOMEPAGE="http://www.gnome.org/projects/epiphany/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="avahi doc networkmanager python spell xulrunner"

# This release should work with xulrunner 1.9, but this revision is a
# stable candidate, so stick with 1.8 here.
# xulrunner-1.9 can be achieved via --with-engine=xulrunner, while
# --with-engine=mozilla goes with 1.8

RDEPEND=">=dev-libs/glib-2.16.0
	>=x11-libs/gtk+-2.12.0
	>=dev-libs/libxml2-2.6.12
	>=dev-libs/libxslt-1.1.7
	>=gnome-base/libglade-2.3.1
	>=gnome-base/libgnome-2.14
	>=gnome-base/libgnomeui-2.14
	>=gnome-base/gnome-desktop-2.9.91
	>=x11-libs/startup-notification-0.5
	>=x11-libs/libnotify-0.4
	>=dev-libs/dbus-glib-0.71
	>=gnome-base/gconf-2
	>=app-text/iso-codes-0.35
	avahi? ( >=net-dns/avahi-0.6.22 )
	networkmanager? ( net-misc/networkmanager )
	!xulrunner? ( =www-client/mozilla-firefox-2* )
	xulrunner? ( =net-libs/xulrunner-1.8* )
	python? (
		>=dev-lang/python-2.3
		>=dev-python/pygtk-2.7.1
		>=dev-python/gnome-python-2.6
	)
	spell? ( app-text/enchant )
	x11-themes/gnome-icon-theme"
DEPEND="${RDEPEND}
	app-text/scrollkeeper
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35
	>=app-text/gnome-doc-utils-0.3.2
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-scrollkeeper
		--with-engine=mozilla
		--enable-certificate-manager
		--with-distributor-name=Gentoo
		$(use_enable avahi zeroconf)
		$(use_enable networkmanager network-manager)
		$(use_enable spell spell-checker)
		$(use_enable python)"

	if use xulrunner; then
		G2CONF="${G2CONF} --with-gecko=xulrunner"
	else
		G2CONF="${G2CONF} --with-gecko=firefox"
	fi
}

src_unpack() {
	gnome2_src_unpack

	# build fix with firefox 2.0 (bug #230834)
	epatch "${FILESDIR}/${P}-firefox2.0-header-fix.patch"

	# fix libnotify crasher (bug #250031)
	epatch "${FILESDIR}/${P}-notify-crash-fix.patch"
}

src_compile() {
	addpredict /usr/$(get_libdir)/mozilla-firefox/components/xpti.dat
	addpredict /usr/$(get_libdir)/mozilla-firefox/components/xpti.dat.tmp
	addpredict /usr/$(get_libdir)/mozilla-firefox/components/compreg.dat.tmp

	addpredict /usr/$(get_libdir)/xulrunner/components/xpti.dat
	addpredict /usr/$(get_libdir)/xulrunner/components/xpti.dat.tmp
	addpredict /usr/$(get_libdir)/xulrunner/components/compreg.dat.tmp

	# Why are these write-opened per bug #228589 and bug #253043
	addpredict /usr/$(get_libdir)/mozilla/components/xpti.dat
	addpredict /usr/$(get_libdir)/mozilla/components/xpti.dat.tmp
	addpredict /usr/$(get_libdir)/mozilla/components/compreg.dat.tmp

	gnome2_src_compile
}

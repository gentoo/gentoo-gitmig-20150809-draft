# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-session/gnome-session-2.14.1.ebuild,v 1.1 2006/05/02 02:26:28 dang Exp $

inherit eutils gnome2

DESCRIPTION="Gnome session manager"
HOMEPAGE="http://www.gnome.org/"
SRC_URI="${SRC_URI}
		 branding? ( mirror://gentoo/gentoo-splash.png )"

LICENSE="GPL-2 LGPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="branding esd ipv6 tcpd"

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2.2
	=gnome-base/gnome-desktop-2*
	gnome-base/gnome-keyring
	esd? ( >=media-sound/esound-0.2.26 )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )"
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.10.40
	>=dev-util/pkgconfig-0.17
	dev-util/intltool
	!gnome-base/gnome-core"

# gnome-base/gnome-core overwrite /usr/bin/gnome-session
DOCS="AUTHORS ChangeLog HACKING NEWS README"

pkg_setup() {
	# TODO: convert libnotify to a configure option
	G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable esd) $(use_enable tcpd tcp-wrappers)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Patch for Gentoo Branding (bug #42687)
	use branding && epatch ${FILESDIR}/${PN}-2.10.0-schema_defaults.patch

	# Patch for optionalizing tcp-wrappers
	epatch ${FILESDIR}/${PN}-2.12.0-optional-tcp-wrappers.patch

	# Implement switch to enable/disable esound support. See bug #6920.
	epatch ${FILESDIR}/${PN}-2.10.0-esd_switch.patch

	#Remove libnotify autocheck so we don't link against it ever. Upstream
	#hasn't decided on any notification standards yet so we don't want to 
	#support notification support at this time
	epatch ${FILESDIR}/${PN}-2.14.0-no_libnotify.patch

	export WANT_AUTOMAKE=1.9.6
	cp aclocal.m4 old_macros.m4
	aclocal -I . || die "aclocal failed"
	autoconf || die "autoconf failed"
	automake || die "automake failed"
	libtoolize --copy --force
}

src_install() {
	gnome2_src_install

	dodir /etc/X11/Sessions
	exeinto /etc/X11/Sessions
	doexe ${FILESDIR}/Gnome

	# Our own splash for world domination
	if use branding ; then
		insinto /usr/share/pixmaps/splash/
		doins ${DISTDIR}/gentoo-splash.png
	fi
}

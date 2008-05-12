# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-1.4.6.ebuild,v 1.4 2008/05/12 15:35:51 corsair Exp $

inherit flag-o-matic

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.atheme.org/${MY_P}.tgz
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="chardet dbus nls libsamplerate"

RDEPEND="dbus? ( >=dev-libs/dbus-glib-0.60 )
	libsamplerate? ( media-libs/libsamplerate )
	>=dev-libs/libmcs-0.6.0
	>=dev-libs/libmowgli-0.5.0
	dev-libs/libxml2
	>=gnome-base/libglade-2.3.1
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.10"

DEPEND="${RDEPEND}
	!media-plugins/audacious-plugins-ugly
	>=dev-util/pkgconfig-0.9.0
	nls? ( dev-util/intltool )"

PDEPEND=">=media-plugins/audacious-plugins-1.4.5"

src_compile() {
	econf \
		$(use_enable chardet) \
		$(use_enable dbus) \
		$(use_enable nls) \
		$(use_enable libsamplerate samplerate) \
		|| die

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS NEWS README

	# Gentoo_ice skin installation; bug #109772
	insinto /usr/share/audacious/Skins/gentoo_ice
	doins "${WORKDIR}"/gentoo_ice/*
	docinto gentoo_ice
	dodoc "${WORKDIR}"/README
}

pkg_postinst() {
	elog "Note that you need to recompile *all* third-party plugins for Audacious 1.4"
	elog "Plugins compiled against 1.3 will not be loaded."
	if ! useq dbus ; then
		eerror "Unsupported configuration: D-Bus disabled"
		ewarn "D-Bus has been disabled. Note that audtool will not be provided, you will not"
		ewarn "be to able to get song information from scripts or control the player remotely."
		ewarn "This configuration is provided for people heavily opposed to D-Bus that are able "
		ewarn "to live with the loss of functionality that this implies. Reports about remote "
		ewarn "control or multiple instances of Audacious being launched will be *closed*."
	else
		elog "Remote control is now only provided over D-Bus. Audacious offers both a private "
		elog "interface and an MPRIS compliant interface on the bus. The older interface using "
		elog "beepctrl.h is no longer present."
	fi
}

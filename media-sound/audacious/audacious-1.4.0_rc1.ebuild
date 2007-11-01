# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/audacious/audacious-1.4.0_rc1.ebuild,v 1.1 2007/11/01 23:51:04 chainsaw Exp $

inherit flag-o-matic

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="http://audacious-media-player.org/"
SRC_URI="http://distfiles.atheme.org/${MY_P}.tgz
	 mirror://gentoo/gentoo_ice-xmms-0.2.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="chardet dbus nls"

RDEPEND="dbus? ( >=dev-libs/dbus-glib-0.60 )
	>=dev-libs/libmcs-0.6.0
	>=dev-libs/libmowgli-0.5.0
	dev-libs/libxml2
	>=gnome-base/libglade-2.3.1
	media-libs/libsamplerate
	>=x11-libs/gtk+-2.6
	>=dev-libs/glib-2.10"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9.0
	nls? ( dev-util/intltool )"

PDEPEND=">=media-plugins/audacious-plugins-1.4.0_rc1"

src_compile() {
	econf \
		--enable-samplerate \
		$(use_enable chardet) \
		$(use_enable dbus) \
		$(use_enable nls) \
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
	elog "Plugins compiled against 1.3 will not be loaded. Remote control is now only "
	elog "provided over D-Bus. Audacious offers both a private interface and an MPRIS "
	elog "compliant interface on the bus."
}

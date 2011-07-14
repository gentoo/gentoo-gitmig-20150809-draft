# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.5.0_pre20110313.ebuild,v 1.4 2011/07/14 21:15:08 hwoarang Exp $

EAPI="2"
WANT_AUTOMAKE="1.9"
inherit multilib autotools eutils

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager"
HOMEPAGE="http://openbox.org/"
SRC_URI="http://dev.gentoo.org/~hwoarang/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug imlib nls session startup-notification static-libs"

RDEPEND="dev-libs/glib:2
	>=dev-libs/libxml2-2.0
	>=media-libs/fontconfig-2
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXt
	>=x11-libs/pango-1.8[X]
	imlib? ( media-libs/imlib2 )
	sys-devel/gettext
	startup-notification? ( >=x11-libs/startup-notification-0.8 )
	x11-libs/libXinerama"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	app-text/docbook2X
	dev-util/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	x11-proto/xineramaproto"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-gnome-session-3.4.9.patch
	epatch "${FILESDIR}"/${PN}-as-needed.patch
	eautopoint
	eautoreconf
}

src_configure() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable debug) \
		$(use_enable imlib imlib2) \
		$(use_enable nls) \
		$(use_enable startup-notification) \
		$(use_enable session session-management) \
		$(use_enable static-libs static) \
		--with-x
}

src_install() {
	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox-session" > "${D}/etc/X11/Sessions/${PN}"
	fperms a+x /etc/X11/Sessions/${PN}
	emake DESTDIR="${D}" install || die "emake install failed"
	! use static-libs && rm "${D}"/usr/$(get_libdir)/lib{obt,obrender}.la
}

# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.4.7.2.ebuild,v 1.9 2009/01/09 15:18:46 remi Exp $

inherit eutils

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager."
HOMEPAGE="http://icculus.org/openbox/"
SRC_URI="http://icculus.org/openbox/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="alpha amd64 hppa ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="nls startup-notification xinerama"

RDEPEND=">=dev-libs/glib-2.6
	>=dev-libs/libxml2-2.0
	>=media-libs/fontconfig-2
	x11-libs/libXft
	x11-libs/libXrandr
	x11-libs/libXt
	>=x11-libs/pango-1.8
	nls? ( sys-devel/gettext )
	startup-notification? ( >=x11-libs/startup-notification-0.8 )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	xinerama? ( x11-proto/xineramaproto )"

pkg_setup() {
	if ! built_with_use --missing true x11-libs/pango X; then
		eerror "Please rebuild x11-libs/pango with the X USE flag enabled."
		die "x11-libs/pango needs X USE flag"
	fi
}

src_compile() {
	econf \
		--docdir=/usr/share/doc/${PF} \
		$(use_enable nls) \
		$(use_enable startup-notification) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox-session" > "${D}/etc/X11/Sessions/${PN}"
	fperms a+x /etc/X11/Sessions/${PN}

	emake DESTDIR="${D}" install || die "emake install failed"
}

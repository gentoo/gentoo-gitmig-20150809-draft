# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/openbox/openbox-3.3.1.ebuild,v 1.2 2006/12/07 02:04:41 flameeyes Exp $

inherit eutils

DESCRIPTION="A standards compliant, fast, light-weight, extensible window manager."
HOMEPAGE="http://icculus.org/openbox/"
SRC_URI="http://icculus.org/openbox/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="nls pango startup-notification xinerama"

RDEPEND=">=dev-libs/glib-2
	>=dev-libs/libxml2-2.0
	>=media-libs/fontconfig-2
	virtual/xft
	x11-libs/libXrandr
	x11-libs/libXt
	pango? ( x11-libs/pango )
	startup-notification? ( x11-libs/startup-notification )
	xinerama? ( x11-libs/libXinerama )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xextproto
	x11-proto/xf86vidmodeproto
	xinerama? ( x11-proto/xineramaproto )"

src_compile() {
	econf \
		$(use_enable nls) \
		$(use_enable pango) \
		$(use_enable startup-notification) \
		|| die "econf failed"
	emake || die "emake failed"
}

src_install() {
	dodir /etc/X11/Sessions
	echo "/usr/bin/openbox" > "${D}/etc/X11/Sessions/openbox"
	fperms a+x /etc/X11/Sessions/openbox

	insinto /usr/share/xsessions
	doins "${FILESDIR}/${PN}.desktop"

	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc ABOUT-NLS AUTHORS CHANGELOG COMPLIANCE README
}

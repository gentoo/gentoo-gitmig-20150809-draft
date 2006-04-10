# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/blackbox/blackbox-0.70.0.ebuild,v 1.11 2006/04/10 07:27:36 pyrania Exp $

DESCRIPTION="A small, fast, full-featured window manager for X"
HOMEPAGE="http://blackboxwm.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}wm/${P}.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="nls truetype debug"

RDEPEND="|| ( ( x11-libs/libXft x11-libs/libXt ) virtual/x11 )
		nls? ( sys-devel/gettext )
		truetype? ( media-libs/freetype )"
DEPEND="${RDEPEND}
	|| ( ( x11-proto/xextproto ) virtual/x11 )
	dev-util/pkgconfig
	>=sys-apps/sed-4"

PROVIDE="virtual/blackbox"

src_compile() {
	econf \
		--sysconfdir=/etc/X11/${PN} \
		$(use_enable nls) \
		$(use_enable truetype xft) \
		$(use_enable debug) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS COMPLIANCE ChangeLog* INSTALL LICENSE README* TODO

	dodir /etc/X11/Sessions
	echo "/usr/bin/${PN}" > ${D}/etc/X11/Sessions/${PN}
	fperms a+x /etc/X11/Sessions/${PN}

	insinto /usr/share/xsessions
	doins ${FILESDIR}/${PN}.desktop
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-emulation/gsnes9x/gsnes9x-3.12.ebuild,v 1.3 2006/11/02 00:21:04 nyhm Exp $

WANT_AUTOCONF=latest
WANT_AUTOMAKE=1.9
inherit autotools eutils

DESCRIPTION="GNOME front-end for the Snes9X SNES emulator"
HOMEPAGE="http://sourceforge.net/projects/gsnes9x/"
SRC_URI="mirror://sourceforge/gsnes9x/GSnes9x-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug esd nls"

RDEPEND="=gnome-base/gnome-libs-1*
	=gnome-base/orbit-0*
	esd? ( media-sound/esound )
	nls? ( virtual/libintl )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/GSnes9x-${PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-sandbox.patch"
	AT_M4DIR=macros eautoreconf
}

src_compile() {
	econf \
		$(use_with esd) \
		$(use_enable debug) \
		$(use_enable nls) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	rm -rf "${D}"/usr/share/gnome/apps
	make_desktop_entry GSnes9x GSnes9x gsnes9x-icon.png
	dodoc AUTHORS ChangeLog NEWS README
}

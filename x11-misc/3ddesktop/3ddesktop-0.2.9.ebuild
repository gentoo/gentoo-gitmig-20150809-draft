# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/3ddesktop/3ddesktop-0.2.9.ebuild,v 1.11 2010/09/16 17:34:48 scarabeus Exp $

inherit autotools eutils

DESCRIPTION="OpenGL virtual desktop switching"
HOMEPAGE="http://desk3d.sourceforge.net/"
SRC_URI="mirror://sourceforge/desk3d/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/libX11
	x11-libs/libXmu
	x11-libs/libXt
	x11-libs/libXext
	x11-libs/libXi
	x11-libs/libXxf86vm
	media-libs/imlib2
	media-libs/freeglut
	media-libs/freetype"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
	x11-proto/xproto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-gcc4.patch"
	epatch "${FILESDIR}/${P}-asneeded.patch"
	epatch "${FILESDIR}/${P}-missing-include.patch"

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc README AUTHORS TODO ChangeLog README.windowmanagers
}

pkg_postinst() {
	einfo
	einfo "This ebuild installed a configuration file called /etc/3ddesktop.conf"
	einfo "The default configuration makes a screenshot of the virtual desktops"
	einfo "every X seconds. This is non-optimal behavior."
	einfo
	einfo "To enable a more intelligent way of updating the virtual desktops,"
	einfo "execute the following:"
	einfo
	einfo "  echo \"AutoAcquire 0\" >> /etc/3ddesktop.conf"
	einfo
	einfo "This will cause 3ddesktop to update the virtual desktop snapshots"
	einfo "only when a 3d desktop switch is required."
	einfo
}

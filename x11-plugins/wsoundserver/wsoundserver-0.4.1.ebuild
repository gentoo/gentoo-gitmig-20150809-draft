# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wsoundserver/wsoundserver-0.4.1.ebuild,v 1.2 2005/06/16 08:37:16 dholm Exp $

MY_P="${P/wsoundserver/WSoundServer}-new"
S="${WORKDIR}/${MY_P}"

IUSE="esd"

DESCRIPTION="WindowMaker sound server"
SRC_URI="http://vlaadworld.net/public/${MY_P}.tar.gz"
HOMEPAGE="http://vlaadworld.net/"

DEPEND="virtual/x11
	>=x11-wm/windowmaker-0.91.0-r1
	>=x11-libs/libdockapp-0.6.0
	>=x11-libs/libPropList-0.10.1-r3
	>=media-libs/audiofile-0.2.6-r1
	esd? ( >=media-sound/esound-0.2.34 )"
RDEPEND="${DEPEND}
	>=media-sound/wmsound-data-1.0.0"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc ~x86"

src_compile() {
	local myconf="--prefix=/usr --with-x --sysconfdir=/etc/X11"

	myconf="${myconf} `use_enable esd`"

	cd ${S}
	emake clean >/dev/null 2>&1
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	cd ${S}
	einstall sysconfdir=/etc/X11 || die "make install failed"
	dodoc AUTHORS ChangeLog README

	insinto /usr/share/WindowMaker/Pixmaps
	doins ${FILESDIR}/WSoundServer.xpm
}

pkg_postinst() {
	einfo "This is Largo's WSoundServer."
	einfo "It supports not only 8 and 16 bit .wav files"
	einfo "as the original does"
}


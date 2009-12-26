# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/anyremote/anyremote-5.0-r1.ebuild,v 1.1 2009/12/26 13:25:21 hwoarang Exp $

EAPI="2"

inherit autotools

DESCRIPTION="Anyremote provides wireless bluetooth, infrared or cable remote control service"
HOMEPAGE="http://anyremote.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bluetooth dbus"

RDEPEND="bluetooth? ( || ( net-wireless/bluez ( net-wireless/bluez-libs net-wireless/bluez-utils ) ) )
	dbus? ( sys-apps/dbus )
	x11-libs/libXtst"

DEPEND="${RDEPEND}"

src_prepare() {
	#workaround to badly broken autotools scripts by upstream
	sed -i "s/doc\/${PN}/doc\/${PF}/g" Makefile.am \
		|| die "failed to fix documentation path"
	eautoreconf
}

src_configure() {
	econf --docdir="/usr/share/doc/${PF}/" $(use_enable bluetooth) $(use_enable dbus)
}

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README || die "install doc failed"
}

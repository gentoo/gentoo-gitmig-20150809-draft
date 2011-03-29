# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/ideviceinstaller/ideviceinstaller-1.0.0.ebuild,v 1.1 2011/03/29 08:11:21 ssuominen Exp $

EAPI=4
inherit eutils

DESCRIPTION="A tool to interact with the installation_proxy of an Apple's iDevice"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="http://www.libimobiledevice.org/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=app-pda/libimobiledevice-1.0.0
	>=app-pda/libplist-0.15
	>=dev-libs/libzip-0.8"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${P}-libgen_h.patch
	sed -i -e 's:-Werror -g::' configure || die
}

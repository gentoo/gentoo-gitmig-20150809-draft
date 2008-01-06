# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/hal-info/hal-info-20071030.ebuild,v 1.1 2008/01/06 06:44:41 compnerd Exp $

inherit eutils

DESCRIPTION="The fdi scripts that HAL uses"
HOMEPAGE="http://hal.freedesktop.org/"
SRC_URI="http://hal.freedesktop.org/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-apps/hal-0.5.10"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack "${A}"
	cd "${S}"

	epatch "${FILESDIR}/01_dell_cdrom_nopoll.patch"
	epatch "${FILESDIR}/02_hardware_brightness_fixups.patch"
	epatch "${FILESDIR}/03_feiya_memory_bar.patch"
}

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed."
}

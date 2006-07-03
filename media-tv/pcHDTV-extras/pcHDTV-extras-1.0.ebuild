# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/pcHDTV-extras/pcHDTV-extras-1.0.ebuild,v 1.1 2006/07/03 13:37:31 vapier Exp $

inherit multilib

DESCRIPTION="firmware/udev files for HD-2000 and HD-3000 cards"
HOMEPAGE="http://www.pchdtv.com/"
SRC_URI="http://www.pchdtv.com/downloads/pcHDTV-extras.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}/${PN}

src_compile() { :; }

src_install() {
	insinto /$(get_libdir)/firmware
	doins firmware/*.fw || die
	insinto /etc/udev.d/rules.d
	doins udev/10-pchdtv.rules || die
	dodoc README scripts/patch_modprobe.sh
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libptp2/libptp2-1.0.2.ebuild,v 1.1 2005/06/16 14:13:12 dragonheart Exp $

inherit eutils

DESCRIPTION="Library communicating with PTP enabled devices (digital photo cameras and so on)."
HOMEPAGE="http://sourceforge.net/projects/libptp/"
SRC_URI="mirror://sourceforge/libptp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~ppc64 ~x86"
IUSE=""
RDEPEND=">=dev-libs/libusb-0.1.8"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-libusbversion.patch
}

src_test() {
	if hasq userpriv "${FEATURES}" || hasq sandbox "${FEATURES}" || hasq usersandbox "${FEATURES}";
	then
		einfo "Sorry cannot test with userpriv, usersandbox or sandbox features"
	else
		env LD_LIBRARY_PATH=./src/.libs/ ./src/ptpcam -l || die "failed test"
	fi
}

src_install() {
	emake install DESTDIR=${D} || die
}

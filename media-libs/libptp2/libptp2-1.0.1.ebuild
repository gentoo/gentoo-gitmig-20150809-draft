# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libptp2/libptp2-1.0.1.ebuild,v 1.3 2004/11/20 06:34:28 dragonheart Exp $

DESCRIPTION="Library communicating with PTP enabled devices (digital photo cameras and so on)."
HOMEPAGE="http://sourceforge.net/projects/libptp/"
SRC_URI="mirror://sourceforge/libptp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE=""
RDEPEND="dev-libs/libusb"
DEPEND="${RDEPEND}
	sys-apps/gawk
	sys-apps/grep"

src_compile() {
	econf || die "failed to configure"
	# Parallel make fails - 
	# https://sourceforge.net/tracker/index.php?func=detail&aid=1009488&group_id=40071&atid=426963
	emake -j1 || die "failed to make"
}

src_test() {
	env LD_LIBRARY_PATH=./usr/lib/ ./usr/bin/ptpcam -l || die "failed test"
}

src_install() {
	emake install DESTDIR=${D} || die
}

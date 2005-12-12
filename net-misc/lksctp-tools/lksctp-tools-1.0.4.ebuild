# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lksctp-tools/lksctp-tools-1.0.4.ebuild,v 1.1 2005/12/12 08:30:55 robbat2 Exp $

inherit eutils

DESCRIPTION="Tools for Linux Kernel Stream Control Transmission Protocol implementation"
HOMEPAGE="http://lksctp.sourceforge.net/"
SRC_URI="mirror://sourceforge/lksctp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# I don't known if *BSD has the support needed at all
# hence the lockdown to glibc and linux26-headers
DEPEND="sys-libs/glibc
		>=sys-kernel/linux-headers-2.6"
#RDEPEND=""

src_unpack() {
	unpack ${A}
	cd ${S} && ./bootstrap || die "Failed to bootstrap"
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README ROADMAP doc/*txt
}

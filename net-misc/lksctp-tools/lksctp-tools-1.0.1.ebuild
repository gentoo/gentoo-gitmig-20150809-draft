# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lksctp-tools/lksctp-tools-1.0.1.ebuild,v 1.1 2004/11/24 01:35:05 robbat2 Exp $

inherit eutils
DESCRIPTION="IPAudit monitors network activity on a network by host, protocol and port."
HOMEPAGE="http://lksctp.sourceforge.net/"
SRC_URI="mirror://sourceforge/lksctp/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
# I don't known if *BSD has the support needed at all
# hence the lockdown to glibc and linux26-headers
DEPEND="sys-libs/glibc
		sys-kernel/linux26-headers"
#RDEPEND=""

src_compile() {
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README ROADMAP doc/*txt
}


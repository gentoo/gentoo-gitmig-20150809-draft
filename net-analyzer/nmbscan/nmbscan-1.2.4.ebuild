# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/nmbscan/nmbscan-1.2.4.ebuild,v 1.5 2005/10/18 02:25:00 agriffis Exp $

inherit eutils

DESCRIPTION="netbios scanner"
HOMEPAGE="http://gbarbier.free.fr/prj/dev/#nmbscan"
SRC_URI="http://gbarbier.free.fr/prj/dev/down/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc x86"
IUSE=""
DEPEND=""
RDEPEND="app-shells/bash
	net-dns/bind-tools
	net-fs/samba
	net-misc/iputils
	sys-apps/coreutils
	sys-apps/gawk
	sys-apps/grep
	sys-apps/net-tools
	sys-apps/sed"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${P}-head.diff"
}

src_compile() {
	return
}

src_install() {
	dobin nmbscan
}

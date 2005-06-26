# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/slurm/slurm-0.3.3.ebuild,v 1.3 2005/06/26 03:47:20 vanquirius Exp $

inherit eutils

DESCRIPTION="Realtime network interface monitor based on FreeBSD's pppstatus"
HOMEPAGE="http://www.raisdorf.net/slurm/"
SRC_URI="http://www.raisdorf.net/files/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86 ~sparc"
IUSE=""

DEPEND="sys-libs/ncurses"

src_install() {
	# binary
	dobin slurm

	# themes to use with -t option
	insinto /usr/share/${PN}/themes
	doins themes/*.theme

	# manual and other docs
	doman slurm.1
	dodoc AUTHORS ChangeLog COPYING COPYRIGHT FAQ INSTALL KEYS README THANKS \
		THEMES.txt TODO
}

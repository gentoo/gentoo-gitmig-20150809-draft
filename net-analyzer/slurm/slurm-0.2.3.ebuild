# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/slurm/slurm-0.2.3.ebuild,v 1.6 2005/03/22 14:59:41 vanquirius Exp $

inherit eutils

DESCRIPTION="Realtime network interface monitor based on FreeBSD's pppstatus"
HOMEPAGE="http://www.raisdorf.net/slurm/"
SRC_URI="http://www.raisdorf.net/files/code/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

DEPEND="sys-libs/ncurses"

src_compile() {
	# fixes some "transmited" typos and adds theme support
	epatch ${FILESDIR}/${P}-theme.patch || "patch died"

	econf || die "configure died"
	emake || die "make failed"
}

src_install() {
	# binary
	dobin slurm

	# sample theme to use with -t option
	insinto /usr/share/${PN}
	doins theme.sample

	# manual and other docs
	doman slurm.1
	dodoc Changelog COPYRIGHT KEYS README THANKS TODO
}

pkg_postinst() {
	einfo
	einfo "This version of slurm has a theme support (-t option)"
	einfo "A sample themefile can be found at /usr/share/${PN}/theme.sample"
	einfo
}

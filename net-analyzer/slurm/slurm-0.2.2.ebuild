# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/slurm/slurm-0.2.2.ebuild,v 1.2 2003/05/04 06:39:08 killian Exp $

DESCRIPTION="Realtime network interface monitor based on FreeBSD's pppstatus"
HOMEPAGE="http://www.raisdorf.net/slurm/"
SRC_URI="http://www.raisdorf.net/files/code/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="sys-libs/ncurses"

# internal use flag for alternative color set ;>
IUSE="altcolors"

src_compile() {
    # fixes some typos and color usage
    epatch "${FILESDIR}/slurm-0.2.2-fix-gentoo.patch"
    # apply alternative color set (red & white)
    use altcolors && epatch "${FILESDIR}/slurm-0.2.2-altcolors-gentoo.patch"

    ./configure || die "configure failed"
    emake || die "make failed"
}

src_install() {
    dobin slurm
    doman slurm.1
    dodoc Changelog COPYRIGHT KEYS README THANKS TODO
}

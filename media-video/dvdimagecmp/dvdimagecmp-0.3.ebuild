# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/dvdimagecmp/dvdimagecmp-0.3.ebuild,v 1.1 2007/07/19 06:59:21 zzam Exp $

DESCRIPTION="Tool to compare a burned DVD with an image to check for errors"
HOMEPAGE="ftp://sunsite.unc.edu/pub/linux/apps/video/"
SRC_URI="ftp://sunsite.unc.edu/pub/linux/apps/video/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""

src_compile() {
	emake CFLAGS="$CFLAGS" || die "make failed"
}

src_install() {
	dobin dvdimagecmp
	dodoc CHANGES README *.lsm
}

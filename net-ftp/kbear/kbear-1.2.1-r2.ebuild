# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-1.2.1-r2.ebuild,v 1.13 2003/02/13 14:04:25 vapier Exp $
inherit kde-base 

DESCRIPTION="An FTP Manager"
SRC_URI="mirror://sourceforge/kbear/${P}.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="x86 sparc "

need-kde 2.1.1

src_unpack() {

    kde_src_unpack all patch

}

# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-1.2.1-r2.ebuild,v 1.6 2002/07/27 13:53:49 danarmak Exp $
inherit kde-base 

DESCRIPTION="An FTP Manager"
SRC_URI="mirror://sourceforge/kbear/${P}.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"

SLOT="2"
LICENSE="GPL"
KEYWORDS="x86"

need-kde 2.1.1

src_unpack() {

    base_src_unpack all patch

}

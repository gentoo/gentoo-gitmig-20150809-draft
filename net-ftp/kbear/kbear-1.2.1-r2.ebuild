# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-ftp/kbear/kbear-1.2.1-r2.ebuild,v 1.4 2002/07/11 06:30:46 drobbins Exp $

inherit kde-base || die

DESCRIPTION="An FTP Manager"
SRC_URI="http://download.sourceforge.net/kbear/${P}.src.tar.bz2"
HOMEPAGE="http://kbear.sourceforge.net"

need-kde 2.1.1

src_unpack() {

    base_src_unpack all patch

}

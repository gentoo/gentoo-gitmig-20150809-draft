# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-1.2.ebuild,v 1.2 2002/08/01 11:40:16 seemant Exp $
inherit kde-base

need-kde 3

need-autoconf 2.1

DESCRIPTION="KDE MSN Messenger"
SRC_URI="mirror://sourceforge/kmerlin/${P}.tar.gz"
HOMEPAGE="http://kmerlin.olsd.de"

LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {

    base_src_unpack
    
    # the pregenerated configure script is buggy
    cd ${S}
    rm configure configure.in
    
}

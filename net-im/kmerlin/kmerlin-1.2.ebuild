# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/kmerlin/kmerlin-1.2.ebuild,v 1.3 2002/10/04 06:04:42 vapier Exp $
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

# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Your Name <your email>
# $Header: /var/cvsroot/gentoo-x86/media-gfx/qiv/qiv-1.6.ebuild,v 1.1 2001/06/22 05:14:11 thread Exp $

#P=
S=${WORKDIR}/${P}
DESCRIPTION="Quick Image Viewer"
SRC_URI="http://www.klografx.net/qiv/download/${P}-src.tgz"
HOMEPAGE="http://www.klograft.net/qiv"

DEPEND="virtual/glibc sys-devel/gcc
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.7
	virtual/x11"

src_compile() {

    try perl /usr/portage/media-gfx/qiv/files/fix_prefix.pl ${S} ${WORKDIR}/../image
    try make

}

src_install () {

    try make install

}


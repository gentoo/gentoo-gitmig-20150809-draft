# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libdvbpsi/libdvbpsi-0.1.1.ebuild,v 1.1 2002/08/02 17:25:16 raker Exp $

DESCRIPTION="library for MPEG TS/DVB PSI tables decoding and generation"
HOMEPAGE="http://www.videolan.org/libdvbpsi"
SRC_URI="http://www.videolan.org/pub/videolan/libdvbpsi/0.1.1/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 -ppc -sparc -sparc64"

DEPEND=""
#RDEPEND=""

S=${WORKDIR}/${P}

src_compile() {

	econf \
		--enable-release || die "econf failed"

	emake || die "emake failed"

}

src_install () {

	einstall || die "einstall failed"

}

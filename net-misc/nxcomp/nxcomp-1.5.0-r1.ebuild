# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxcomp/nxcomp-1.5.0-r1.ebuild,v 1.1 2005/12/15 17:29:33 agriffis Exp $

inherit eutils multilib

DESCRIPTION="X11 protocol compression library"
HOMEPAGE="http://www.nomachine.com/"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

SRC_URI="http://web04.nomachine.com/download/1.5.0/sources/$P-80.tar.gz"

DEPEND="media-libs/jpeg
	media-libs/libpng
	virtual/libc
	sys-libs/zlib
	virtual/x11"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/nxcomp-1.5.0-r1-pic.patch
}

src_compile() {
	./configure
	emake || die "emake failed"
}

src_install() {
	into /usr/NX
	dolib libXcomp.so*
	if [[ $(get_libdir) != lib ]]; then
		# necessary for nxclient to work, it seems
		ln -s "$(get_libdir)" ${D}/usr/NX/lib
	fi

	preplib /usr/NX/lib

	insinto /usr/NX/include
	doins NX*.h MD5.h

	dodoc README README-IPAQ LICENSE VERSION

	dodir /etc/env.d
	echo "LDPATH=/usr/NX/$(get_libdir)" >${D}/etc/env.d/50nxcomp
}

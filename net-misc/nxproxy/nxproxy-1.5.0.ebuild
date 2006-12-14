# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxproxy/nxproxy-1.5.0.ebuild,v 1.4 2006/12/14 15:07:34 beu Exp $

inherit flag-o-matic multilib

DESCRIPTION="X11 protocol compression library wrapper"
HOMEPAGE="http://www.nomachine.com/"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc"

SRC_URI="http://web04.nomachine.com/download/1.5.0/sources/nxproxy-$PV-9.tar.gz"

DEPEND="=net-misc/nxcomp-1.5*
	media-libs/jpeg
	media-libs/libpng"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	# unfortunately this package doesn't honor environment variables correctly
	# in configure, so append-flags doesn't work.
	sed -i '/^C\(XX\|C\)INCLUDES =/s/$/ -I\/usr\/NX\/include/' Makefile.in
}

src_compile() {
	append-ldflags -L/usr/NX/$(get_libdir)
	econf --prefix=/usr/NX || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	into /usr/NX
	dobin nxproxy
	dodoc README README-IPAQ README-VALGRIND VERSION LICENSE
}

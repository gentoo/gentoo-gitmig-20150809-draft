# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/nxproxy/nxproxy-1.5.0-r2.ebuild,v 1.1 2006/04/30 17:48:14 stuart Exp $

inherit flag-o-matic multilib

DESCRIPTION="X11 protocol compression library wrapper"
HOMEPAGE="http://www.nomachine.com/"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"

SRC_URI="http://web04.nomachine.com/download/1.5.0/sources/nxproxy-$PV-9.tar.gz"

DEPEND="~net-misc/nxcomp-1.5.0"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	cd ${S}
	# unfortunately this package doesn't honor environment variables correctly
	# in configure, so append-flags doesn't work.
	sed -i 's/-I *..\/nxcomp/-I\/usr\/NX\/include/' Makefile.in
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

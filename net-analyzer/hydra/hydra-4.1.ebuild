# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-4.1.ebuild,v 1.4 2004/08/16 10:29:27 eldad Exp $

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/${P}-src.tar.gz"

LICENSE="HYDRA GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="dev-libs/openssl
	net-libs/libssh"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile.am
}

src_compile() {
	# has it's own stupid custom configure script
	./configure --prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dobin hydra pw-inspector || die "dobin failed"
	dodoc CHANGES README TODO
}

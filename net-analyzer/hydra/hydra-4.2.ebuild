# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-4.2.ebuild,v 1.1 2004/08/18 04:04:17 squinky86 Exp $

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/${P}-src.tar.gz"

LICENSE="HYDRA GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="gtk"

DEPEND="dev-libs/openssl
	net-libs/libssh
	gtk? ( >=x11-libs/gtk+-1.2 )"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile.am
	if ! use gtk; then
		cp ${FILESDIR}/make_xhydra.sh ./hydra-gtk/make_xhydra.sh
		chmod +x ./hydra-gtk/make_xhydra.sh
	fi
}

src_compile() {
	# has it's own stupid custom configure script
	./configure --prefix=/usr || die "configure failed"
	emake || die "make failed"
}

src_install() {
	dobin hydra pw-inspector || die "dobin failed"
	use gtk && dobin xhydra
	dodoc CHANGES README TODO
}

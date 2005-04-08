# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-4.4.ebuild,v 1.4 2005/04/08 17:57:01 hansmi Exp $

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/"
SRC_URI="http://www.thc.org/releases/${P}-src.tar.gz"

LICENSE="HYDRA GPL-2"
SLOT="0"
KEYWORDS="ppc x86"
IUSE="gtk ssl"

DEPEND="gtk? ( >=x11-libs/gtk+-1.2 )
	ssl? (
		dev-libs/openssl
		=net-libs/libssh-0.1
	)"

S=${WORKDIR}/${P}-src

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i "s:-O2:${CFLAGS}:" Makefile.am

	cd hydra-gtk
	rm make_xhydra.sh || die
	if use gtk ; then
		make distclean || die
	fi
}

src_compile() {
	# has it's own stupid custom configure script
	./configure --prefix=/usr || die "configure failed"
	sed -i \
		-e '/^XDEFINES=/s:=.*:=:' \
		-e '/^XLIBS=/s:=.*:=:' \
		-e '/^XLIBPATHS/s:=.*:=:' \
		-e '/^XIPATHS=/s:=.*:=:' \
		Makefile || die "pruning vars"
	if use ssl ; then
		sed -i \
			-e '/^XDEFINES=/s:=:=-DLIBOPENSSL -DLIBSSH:' \
			-e '/^XLIBS=/s:=:=-lcrypto -lssl -lssh:' \
			Makefile || die "adding ssl"
	fi
	emake || die "make failed"

	if use gtk ; then
		cd hydra-gtk
		econf || die
		emake || die
	fi
}

src_install() {
	dobin hydra pw-inspector || die "dobin failed"
	if use gtk ; then
		dobin hydra-gtk/src/xhydra || die "gtk"
	fi
	dodoc CHANGES README TODO
}

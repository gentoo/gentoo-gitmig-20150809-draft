# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/hydra/hydra-5.4-r3.ebuild,v 1.1 2009/12/18 10:51:29 pva Exp $

EAPI="2"
inherit eutils

DESCRIPTION="Advanced parallized login hacker"
HOMEPAGE="http://www.thc.org/thc-hydra/"
SRC_URI="http://www.thc.org/releases/${P}-src.tar.gz"

LICENSE="HYDRA GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gtk ssl"

DEPEND="gtk? ( >=x11-libs/gtk+-1.2 )
	ssl? (
		dev-libs/openssl
		>=net-libs/libssh-0.4.0
	)"

S=${WORKDIR}/${P}-src

src_prepare() {
	sed -i "s:-O2:${CFLAGS}:" Makefile.am || die "sed failed"
	epatch "${FILESDIR}/${P}-_FORTIFY_SOURCE.patch"
	epatch "${FILESDIR}/${P}-free-without-malloc.patch"
	epatch "${FILESDIR}/${P}-libssh-0.4.0.patch"
}

src_configure() {
	./configure \
		--prefix=/usr \
		$(use gtk && echo --disable-xhydra) \
			|| die "configure failed"

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

	if use gtk ; then
		cd hydra-gtk && \
		econf
	fi
}

src_compile() {
	emake || die "make failed"
	if use gtk ; then
		cd hydra-gtk && \
		emake || die "emake hydra-gtk failed"
	fi
}

src_install() {
	dobin hydra pw-inspector || die "dobin failed"
	if use gtk ; then
		dobin hydra-gtk/src/xhydra || die "gtk"
	fi
	dodoc CHANGES README TODO
}

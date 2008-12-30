# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-shells/soapbox/soapbox-0.3.1.ebuild,v 1.3 2008/12/30 20:51:13 angelos Exp $

inherit multilib toolchain-funcs

DESCRIPTION="A preload (sandbox) library to restrict filesystem writes"
HOMEPAGE="http://dag.wieers.com/home-made/soapbox/"
SRC_URI="http://dag.wieers.com/home-made/soapbox/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e "s:/lib:/usr/$(get_libdir):" \
		soapbox.sh || die
}

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		LD="$(tc-getCC)" \
		CFLAGS="${CFLAGS} -fPIC" \
		LDFLAGS="${LDFLAGS}" \
		|| die "emake failed"
}

src_install() {
	dolib.so libsoapbox.so || die "soapsox.so"
	newbin soapbox.sh soapbox || die "soapbox"
	dodoc AUTHORS BUGS ChangeLog README THANKS TODO
}

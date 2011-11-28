# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/rinetd/rinetd-0.62-r1.ebuild,v 1.3 2011/11/28 22:50:03 chainsaw Exp $

EAPI="2"

inherit toolchain-funcs

DESCRIPTION="redirects TCP connections from one IP address and port to another"
HOMEPAGE="http://www.boutell.com/rinetd/"
SRC_URI="http://www.boutell.com/rinetd/http/rinetd.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}

src_prepare() {
	sed -i -e "s:gcc:$(tc-getCC) \$(CFLAGS) \$(LDFLAGS):" Makefile
}

src_compile() {
	emake CFLAGS="${CFLAGS} -DLINUX" LDFLAGS="${LDFLAGS}" || die
}

src_install() {
	dosbin rinetd || die
	newinitd "${FILESDIR}"/rinetd.rc rinetd
	doman rinetd.8
	dodoc CHANGES README
	dohtml index.html
}

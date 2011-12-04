# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batmand/batmand-0.3.2-r1.ebuild,v 1.1 2011/12/04 13:58:49 cedk Exp $

EAPI=2

inherit toolchain-funcs

MY_P=${P/batmand/batman}
DESCRIPTION="Better approach to mobile Ad-Hoc networking"
HOMEPAGE="http://open-mesh.net/"
SRC_URI="http://downloads.open-mesh.net/batman/stable/sources/batman/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_prepare() {
	sed -i \
		-e "/^CFLAGS/s: -O[^[:space:]]* : :" \
		-e "/^CFLAGS/s: -g[^[:space:]]* : :" \
		-e "s/-j \$(NUM_CPUS)//" \
		Makefile || die
}

src_compile() {
	emake CC="$(tc-getCC)" V=1 || die
}

src_install() {
	emake INSTALL_PREFIX="${D}" install || die

	newinitd "${FILESDIR}"/batmand-init.d batmand || die
	newconfd "${FILESDIR}"/batmand-conf.d batmand || die

	doman man/*.8 || die

	dodoc CHANGELOG README THANKS || die
}

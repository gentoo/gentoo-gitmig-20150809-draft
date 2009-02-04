# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batmand/batmand-0.3.ebuild,v 1.3 2009/02/04 21:47:56 maekke Exp $

inherit eutils toolchain-funcs

MY_P=${P/batmand/batman}
DESCRIPTION="Better approach to mobile Ad-Hoc networking"
HOMEPAGE="http://open-mesh.net/"
SRC_URI="http://downloads.open-mesh.net/batman/stable/sources/batman/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/CFLAGS =.*-Wall -O1 -g3/CFLAGS += -Wall/" \
		-e "s/LDFLAGS =/LDFLAGS +=/" \
		-e "s/-j \$(NUM_CPUS)//" \
		Makefile || die "sed failed"
}

src_compile() {
	emake CC="$(tc-getCC)" CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	dosbin batmand

	newinitd "${FILESDIR}"/batmand-init.d batmand
	newconfd "${FILESDIR}"/batmand-conf.d batmand

	dodoc CHANGELOG
}

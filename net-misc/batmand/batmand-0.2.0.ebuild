# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/batmand/batmand-0.2.0.ebuild,v 1.2 2007/08/18 16:25:58 hanno Exp $

inherit eutils toolchain-funcs

MY_PV="0.2-rv451_sources"

DESCRIPTION="Better approach to mobile Ad-Hoc networking"
HOMEPAGE="http://open-mesh.net/batman"
SRC_URI="http://downloads.open-mesh.net/batman/stable/sources/${PN}_${MY_PV}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S=${WORKDIR}/${PN}_${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"

	sed -i \
		-e "s/CFLAGS =.*-Wall -O1 -g3/CFLAGS += -Wall/" \
		-e "s/LDFLAGS =/LDFLAGS +=/" \
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

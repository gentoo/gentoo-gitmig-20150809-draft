# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libnl/libnl-1.0_pre6-r1.ebuild,v 1.2 2010/01/10 08:28:48 robbat2 Exp $

inherit eutils multilib versionator

MY_PV=$(replace_version_separator 2 '-' )-fix1
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A library for applications dealing with netlink socket"
HOMEPAGE="http://people.suug.ch/~tgr/libnl/"
SRC_URI="http://people.suug.ch/~tgr/libnl/files/${MY_P}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~x86"
IUSE=""

S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}/lib"
	sed -i Makefile -e 's:install -o root -g root:install:'

	cd "${S}/include"
	sed -i Makefile -e 's:install -o root -g root:install:g'
	epatch "${FILESDIR}/${PN}-1.0_pre5-include.diff"
	epatch "${FILESDIR}/${P}-__u64_x86_64.patch"
}

src_install() {
	emake DESTDIR="${D}" install || die
}

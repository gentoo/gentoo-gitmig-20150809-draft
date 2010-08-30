# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pcc/pcc-1.0.0_pre100830.ebuild,v 1.1 2010/08/30 19:40:57 patrick Exp $

EAPI=2

inherit eutils versionator autotools

# extract date stamp for later use
ver=$(get_version_component_range 4)
ver=${ver/pre/}

DESCRIPTION="pcc portable c compiler"
HOMEPAGE="http://pcc.ludd.ltu.se"

SRC_URI="http://pcc.ludd.ltu.se/ftp/pub/${PN}/${PN}-$ver.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=">=dev-libs/pcc-libs-${PV}"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-$ver

src_prepare() {
	sed -i -e 's/AC_CHECK_PROG(strip,strip,yes,no)//' configure.ac || die "Failed to fix configure.ac"
	sed -i -e 's/AC_SUBST(strip)//' configure.ac || die "Failed to fix configure.ac more"
	eautoreconf
}

src_compile() {
	# not parallel-safe yet
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

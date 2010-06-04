# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/pcc/pcc-1.0.0_pre100604.ebuild,v 1.1 2010/06/04 13:04:02 patrick Exp $

EAPI=2

inherit eutils versionator

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

src_compile() {
	# not parallel-safe yet
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

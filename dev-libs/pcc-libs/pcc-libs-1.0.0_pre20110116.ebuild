# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pcc-libs/pcc-libs-1.0.0_pre20110116.ebuild,v 1.1 2011/01/16 10:22:51 patrick Exp $

EAPI=2

inherit eutils versionator

# extract date stamp for later use
ver=$(get_version_component_range 4)
ver=${ver/pre/}

DESCRIPTION="pcc compiler support libs"
HOMEPAGE="http://pcc.ludd.ltu.se"

SRC_URI="ftp://pcc.ludd.ltu.se/pub/${PN}/${PN}-${ver}.tgz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${ver}

src_compile() {
	# not parallel-safe yet
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

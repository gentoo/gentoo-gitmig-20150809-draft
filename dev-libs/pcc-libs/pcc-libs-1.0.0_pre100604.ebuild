# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pcc-libs/pcc-libs-1.0.0_pre100604.ebuild,v 1.1 2010/06/04 13:03:11 patrick Exp $

EAPI=2

inherit eutils

DESCRIPTION="pcc compiler support libs"
HOMEPAGE="http://pcc.ludd.ltu.se"

SRC_URI="http://gentooexperimental.org/~patrick/pcc-libs-100604.tbz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_compile() {
	# not parallel-safe yet
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

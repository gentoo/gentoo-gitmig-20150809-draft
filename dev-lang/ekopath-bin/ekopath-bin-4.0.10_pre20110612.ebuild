# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ekopath-bin/ekopath-bin-4.0.10_pre20110612.ebuild,v 1.2 2011/06/15 08:27:58 xarthisius Exp $

EAPI=4

inherit versionator

MY_PN=${PN/-bin}
MY_PV=$(get_version_component_range 1-3)
DATE=$(get_version_component_range 4)
DATE=${DATE/pre}
DATE=${DATE:0:4}-${DATE:4:2}-${DATE:6}

DESCRIPTION="PathScale EKOPath Compiler Suite"
HOMEPAGE="http://www.pathscale.com/ekopath-compiler-suite"
SRC_URI="http://c591116.r16.cf2.rackcdn.com/${MY_PN}/nightly/Linux/${MY_PN}-${DATE}-installer.run"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S=${WORKDIR}

PATHSCALE_SDP_DIR=/opt/${P}

QA_PREBUILT="
	${PATHSCALE_SDP_DIR}/lib/${MY_PV}/x8664/*
	${PATHSCALE_SDP_DIR}/bin/pathcc
	${PATHSCALE_SDP_DIR}/bin/pathas
	${PATHSCALE_SDP_DIR}/bin/assign"

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}"/${P}.run #work around BitRock failing on symlink
	fperms 0755 ${P}.run
}

src_prepare() {
	cat > "99${PN}" <<-EOF
		PATH=/opt/${P}/bin
		ROOTPATH=/opt/${P}/bin
		LDPATH=/opt/${P}/lib
	EOF
}

src_install() {
	./${P}.run \
		--prefix "${D}/opt/${P}" \
		--mode unattended || die
	rm -rf "${D}"/opt/${P}/uninstall || die
	doenvd "99${PN}"
}

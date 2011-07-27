# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ekopath/ekopath-4.0.10_pre20110717.ebuild,v 1.2 2011/07/27 09:34:06 xarthisius Exp $

EAPI=4

inherit versionator

MY_PV=$(get_version_component_range 1-3)
DATE=$(get_version_component_range 4)
DATE=${DATE/pre}
DATE=${DATE:0:4}-${DATE:4:2}-${DATE:6}

DESCRIPTION="PathScale EKOPath Compiler Suite"
HOMEPAGE="http://www.pathscale.com/ekopath-compiler-suite"
SRC_URI="http://c591116.r16.cf2.rackcdn.com/${PN}/nightly/Linux/${PN}-${DATE}-installer.run
	-> ${P}.run"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RESTRICT="mirror"

S=${WORKDIR}

PATHSCALE_SDP_DIR=/opt/${P}

QA_PREBUILT="
	${PATHSCALE_SDP_DIR}/lib/${MY_PV}/x8664/*
	${PATHSCALE_SDP_DIR}/bin/pathcc*
	${PATHSCALE_SDP_DIR}/bin/pathas
	${PATHSCALE_SDP_DIR}/bin/assign"

pkg_pretend() {
	if has_version app-arch/rpm ; then
		ewarn "You have app-arch/rpm installed on your system. Therefore"
		ewarn "${PN} will fail to install due to sandbox violation."
		ewarn "As this cannot be fixed on distribution level, please use"
		ewarn "following workaround:"
		ewarn "  emerge -C rpm && emerge -1 ${PN} && emerge -1 rpm"
		die
	fi
}

src_unpack() {
	cp "${DISTDIR}"/${A} "${S}" || die
	chmod +x "${S}"/${P}.run
}

src_prepare() {
	cat > "99${PN}" <<-EOF
		PATH=/opt/${P}/bin
		ROOTPATH=/opt/${P}/bin
		LDPATH=/opt/${P}/lib:/opt/${P}/lib/${MY_PV}/x8664/64
	EOF
}

src_install() {
	./${P}.run \
		--prefix "${D}/opt/${P}" \
		--mode unattended || die
	rm -rf "${D}"/opt/${P}/uninstall || die
	doenvd "99${PN}"
}

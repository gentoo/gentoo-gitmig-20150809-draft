# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-libs/ipp/ipp-11.1.056.ebuild,v 1.1 2009/10/06 20:51:51 bicatali Exp $

EAPI=2
inherit versionator
RELEASE="$(get_version_component_range 1-2)"
BUILD="$(get_version_component_range 3)"

DESCRIPTION="Intel(R) Integrated Performance Primitive library for multimedia and data processing"
HOMEPAGE="http://developer.intel.com/software/products/ipp/"
SRC_URI=""

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="Intel-SDP"

IUSE=""

DEPEND=""
RDEPEND="~dev-lang/icc-${PV}[ipp]"

DESTINATION="${ROOT}opt/intel/Compiler/${RELEASE}/${BUILD}"

src_install() {
	cat > 36ipp <<-EOF
		IPPROOT=${DESTINATION}/ipp/${IARCH/intel64/em64t}
		LDPATH=\${IPPROOT}/sharedlib
		LIB=\${IPPROOT}/lib
		LIBRARY_PATH=\${IPPROOT}/lib
		CPATH=\${IPPROOT}/include
		NLSPATH=\${IPPROOT}/lib/locale/%l_%t/%N
	EOF
	doenvd 36ipp || die "doenvd 36ipp failed"
}

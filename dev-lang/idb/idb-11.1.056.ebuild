# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/idb/idb-11.1.056.ebuild,v 1.2 2010/04/20 20:58:28 bicatali Exp $

EAPI=2
inherit versionator multilib

RELEASE="$(get_version_component_range 1-2)"
BUILD="$(get_version_component_range 3)"

DESCRIPTION="Intel C/C++/FORTRAN debugger for Linux"
HOMEPAGE="http://www.intel.com/software/products/compilers/"
SRC_URI=""

KEYWORDS="~amd64 ~x86"

LICENSE="Intel-SDP"
SLOT="0"
IUSE="eclipse"

DEPEND=""
RDEPEND="|| ( ~dev-lang/icc-${PV}[idb] ~dev-lang/ifc-${PV}[idb] )
	>=virtual/jre-1.5
	eclipse? ( >=dev-util/eclipse-sdk-3.4 )"

DESTINATION="${ROOT}opt/intel/Compiler/${RELEASE}/${BUILD}"

link_eclipse_plugins() {
	ECLIPSE_V="$1"
	CDT_V="$2"
	einfo "Linking eclipse (v${ECLIPSE_V}) plugin cdt (v${CDT_V})"
	dodir /usr/$(get_libdir)/eclipse-${ECLIPSE_V}/plugins
	dodir /usr/$(get_libdir)/eclipse-${ECLIPSE_V}/features

	for f in "${DESTINATION}/idb/eclipse_support/cdt${CDT_V}/eclipse/plugins"/*; do
		dosym "${ROOT}${f}" /usr/$(get_libdir)/eclipse-${ECLIPSE_V}/plugins
	done

	for f in "${DESTINATION}/idb/eclipse_support/cdt${CDT_V}/eclipse/features"/*; do
		dosym /"${ROOT}${f}" /usr/$(get_libdir)/eclipse-${ECLIPSE_V}/features
	done
	eend $?
}

src_install() {
	cat > 06idb <<-EOF
		NLSPATH=${DESTINATION}/idb/${IARCH}/locale/%l_%t/%N
	EOF
	doenvd 06idb || die "doenvd 06idb failed"
	if use eclipse; then
		if has_version 'dev-util/eclipse-sdk:3.4'; then
			link_eclipse_plugins "3.4" "5.0" || die
		fi
		if has_version 'dev-util/eclipse-sdk:3.5'; then
			link_eclipse_plugins "3.5" "6.0" || die
		fi
	fi
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/openib.eclass,v 1.4 2012/04/18 16:47:30 alexxy Exp $

# @ECLASS: openib.eclass
# @AUTHOR:
# Original Author: Alexey Shvetsov <alexxy@gentoo.org>
# @BLURB: Simplify working with OFED packages

inherit base eutils rpm versionator

EXPORT_FUNCTIONS src_unpack

HOMEPAGE="http://www.openfabrics.org/"
LICENSE="|| ( GPL-2 BSD-2 )"

# @ECLASS-VARIABLE: OFED_VER
# @DESCRIPTION:
# Defines OFED version eg 1.4 or 1.4.0.1

# @ECLASS-VARIABLE: OFED_SUFFIX
# @DESCRIPTION:
# Defines OFED package suffix eg -1.ofed1.4

# @ECLASS-VARIABLE: OFED_SNAPSHOT
# @DESCRIPTION:
# Defines if src tarball is git snapshot

SLOT="${OFED_VER}"

OFED_VERSIONS=(
	"1.5.1"
	"1.5.2"
	"1.5.3"
	"1.5.3.1"
	"1.5.3.2"
	"1.5.4"
	"1.5.4.1"
	"3.2"
	)

block_other_ofed_versions() {
	local slot
	RDEPEND+=" !sys-infiniband/${PN}:0"
	for slot in ${OFED_VERSIONS[@]}; do
		if [[ ${slot} != ${SLOT} ]]; then
			RDEPEDN+=" !sys-infiniband/${PN}:${slot}"
		fi
	done
}

OFED_BASE_VER=$(get_version_component_range 1-3 ${OFED_VER})

SRC_URI="http://www.openfabrics.org/downloads/OFED/ofed-${OFED_BASE_VER}/OFED-${OFED_VER}.tgz"

DOCS=( AUTHORS ChangeLog README TODO )

case ${PN} in
	ofed)
		MY_PN="ofa_kernel"
		;;
	*)
		MY_PN="${PN}"
		;;
esac

case ${PV} in
	*p*)
		MY_PV="${PV/p/}"
		;;
	*)
		MY_PV="${PV}"
		;;
esac

case ${MY_PN} in
	ofa_kernel)
		EXT="tgz"
		;;
	*)
		EXT="tar.gz"
		;;
esac

# if its snapshot then S may be different
if [ -z ${OFED_SNAPSHOT} ]; then
	S="${WORKDIR}/${MY_PN}-${MY_PV}"
else
	S="${WORKDIR}/${MY_PN}-${MY_PV}-${OFED_SUFFIX}"
fi

# @FUNCTION: openib_src_unpack
# @DESCRIPTION:
# This function will unpack OFED packages
openib_src_unpack() {
	unpack ${A}
	rpm_unpack "./OFED-${OFED_VER}/SRPMS/${MY_PN}-${MY_PV}-${OFED_SUFFIX}.src.rpm"
	if [ -z ${OFED_SNAPSHOT} ]; then
		unpack ./${MY_PN}-${MY_PV}.${EXT}
	else
		unpack ./${MY_PN}-${MY_PV}-${OFED_SUFFIX}.${EXT}
	fi
}

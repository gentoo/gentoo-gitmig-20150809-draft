# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.4.2.08.ebuild,v 1.2 2006/02/21 15:27:29 agriffis Exp $

IUSE=""

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip fetch"

inherit java versionator

PV_MAJOR="$(get_version_component_range 1-3 ${PV})"
PV_EXTRA="$(get_version_component_range 4 ${PV})"
HOMEPAGE_PV="$(delete_all_version_separators ${PV_MAJOR})_${PV_EXTRA}"
UPSTREAM_RELEASE="24.5.0"

SRC_URI_BASE="jrockit-${UPSTREAM_RELEASE}-j2sdk${PV_MAJOR}_${PV_EXTRA}-linux-"
SRC_URI="ia64? ( ${SRC_URI_BASE}ipf.bin )
		x86? ( ${SRC_URI_BASE}ia32.bin )
		amd64? ( ${SRC_URI_BASE}ia32.bin )"
DESCRIPTION="BEA WebLogic's J2SE Development Kit, R${UPSTREAM_RELEASE}"

HOMEPAGE="http://commerce.bea.com/products/weblogicjrockit/${PV_MAJOR}/${HOMEPAGE_PV}.jsp"
LICENSE="jrockit"
SLOT="1.4"
KEYWORDS="~amd64 ia64 ~x86"
DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5
	>=app-arch/unzip-5.50-r1"

PROVIDE="virtual/jre
	virtual/jdk"

pkg_nofetch() {
	einfo "Please download ${A} from:"
	einfo ${HOMEPAGE}
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {

	mkdir ${S}
	unzip ${DISTDIR}/${A} -d ${S} || die "Failed to unpack ${A}"

	cd ${S}
	for z in *.zip ; do
		unzip $z || die
		rm $z
	done
}

src_install() {
	local dirs="bin console include jre lib"
	dodir /opt/${P}

	for i in ${dirs} ; do
		cp -R $i ${D}/opt/${P}/ || die
	done

	newdoc README.TXT README
	newdoc "License Agreement.txt" LICENSE

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst
	einfo "Please review the license agreement in /usr/doc/${P}/LICENSE"
	einfo "If you do not agree to the terms of this license, please uninstall this package"
}

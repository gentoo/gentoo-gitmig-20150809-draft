# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.4.2.05.ebuild,v 1.1 2005/03/27 23:31:52 luckyduck Exp $

IUSE=""

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip fetch"

inherit java versionator

PV_MAJOR="$(get_version_component_range 1-3 ${PV})"
PV_EXTRA="$(get_version_component_range 4 ${PV})"
HOMEPAGE_PV="$(delete_all_version_separators ${PV_MAJOR})_${PV_EXTRA}"

SRC_URI_BASE="jrockit-j2sdk${PV_MAJOR}_${PV_EXTRA}-linux-"
SRC_URI="ia64? ( ${SRC_URI_BASE}ipf.bin )
		x86? ( ${SRC_URI_BASE}ia32.bin )"
DESCRIPTION="BEA WebLogic's J2SE Development Kit, version 8.1"

HOMEPAGE="http://commerce.bea.com/downloads/weblogic_jrockit.jsp"
LICENSE="jrockit"
SLOT="1.4"
KEYWORDS="~x86 ~ia64"
DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5
	>=app-arch/unzip-5.50-r1"

PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4
	virtual/java-scheme-2"

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
		unzip $z
		rm $z
	done
}

src_install () {
	local dirs="bin console include jre lib"
	dodir /opt/${P}

	for i in ${dirs} ; do
		cp -dR $i ${D}/opt/${P}/
	done

	newdoc README.TXT README
	newdoc "License Agreement.txt" LICENSE

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Set as default VM if none exists
	einfo "Please review the license agreement in /usr/doc/${P}/LICENSE"
	einfo "If you do not agree to the terms of this license, please uninstall this package"
}

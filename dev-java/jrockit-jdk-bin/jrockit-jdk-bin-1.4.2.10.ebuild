# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.4.2.10.ebuild,v 1.3 2006/07/06 11:05:16 nelchael Exp $

IUSE=""

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip fetch"

inherit java-vm-2 versionator

PV_MAJOR="$(get_version_component_range 1-3 ${PV})"
PV_EXTRA="$(get_version_component_range 4 ${PV})"
HOMEPAGE_PV="$(delete_all_version_separators ${PV_MAJOR})_${PV_EXTRA}"
UPSTREAM_RELEASE="26.3.0"

SRC_URI_BASE="jrockit-R${UPSTREAM_RELEASE}-jdk${PV_MAJOR}_${PV_EXTRA}-linux-"
SRC_URI="ia64? ( ${SRC_URI_BASE}ipf.bin )
		x86? ( ${SRC_URI_BASE}ia32.bin )
		amd64? ( ${SRC_URI_BASE}ia32.bin )"
DESCRIPTION="BEA WebLogic's J2SE Development Kit, R${UPSTREAM_RELEASE}"

HOMEPAGE="http://www.bea.com/framework.jsp?CNT=index.htm&FP=/content/products/jrockit/"
FETCH_URI="http://commerce.bea.com/products/weblogicjrockit/accept_terms142.jsp"
LICENSE="jrockit"
SLOT="1.4"
KEYWORDS="~x86 ~ia64 ~amd64"
DEPEND=">=dev-java/java-config-0.2.5
	>=app-arch/unzip-5.50-r1"

pkg_nofetch() {
	einfo "Please download ${A} from:"
	einfo ${FETCH_URI}
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
	newdoc LICENSE LICENSE

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst
	einfo "Please review the license agreement in /usr/share/doc/${PF}/LICENSE"
	einfo "If you do not agree to the terms of this license, please uninstall this package"
}

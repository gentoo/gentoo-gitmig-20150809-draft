# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.4.2.14_p1.ebuild,v 1.1 2007/08/31 13:23:37 caster Exp $

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# NOTE: this version is special, future standard releases should use some
# ebuild without _pX as a base. If there's none in the tree, check attic at
# sources.g.o

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="strip mirror"
JAVA_SUPPORTS_GENERATION_1="true"
inherit java-vm-2 versionator

PV_MAJOR="$(get_version_component_range 1-3 ${PV})"
PV_EXTRA="$(get_version_component_range 4 ${PV})"
MY_PV="${PV_MAJOR}_${PV_EXTRA}"

SRC_URI_BASE="ftp://anonymous:dev2dev%40bea%2Ecom@ftpna.bea.com/pub/releases/security/jrockit-jdk${MY_PV}-linux_"
SRC_URI="ia64? ( ${SRC_URI_BASE}ia64.tar.gz )
		x86? ( ${SRC_URI_BASE}ia32.tar.gz )"
DESCRIPTION="BEA WebLogic's J2SE Development Kit"

HOMEPAGE="http://commerce.bea.com/products/weblogicjrockit/jrockit_prod_fam.jsp"
LICENSE="jrockit"
SLOT="1.4"
KEYWORDS="-* ~ia64 ~x86"
DEPEND=""
RDEPEND="doc? ( =dev-java/java-sdk-docs-1.4.2* )"
IUSE="doc examples"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/jrockit/libjvm.so
opt/${P}/jre/lib/i386/libjmapi.so
opt/${P}/jre/lib/i386/libawt.so"

QA_EXECSTACK_x86="opt/${P}/bin/*
opt/${P}/jre/bin/*
opt/${P}/jre/lib/i386/jrockit/libjvm.so
opt/${P}/jre/lib/i386/libnet.so"

S="${WORKDIR}/jrockit-jdk${MY_PV}"

src_install() {
	local dirs="bin include jre lib missioncontrol src.zip"

	insinto "/opt/${P}"
	for i in ${dirs} ; do
		doins -r $i || die
	done

	if use examples; then
		doins -r demo || die
	fi

	newdoc README.txt README || die
	dodoc LICENSE || die

	chmod +x ${D}/opt/${P}/bin/* ${D}/opt/${P}/jre/bin/* || die "Could not chmod"
	set_java_env
}

pkg_postinst () {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst
	elog "Please review the license agreement in /usr/share/doc/${PF}/LICENSE"
	elog "If you do not agree to the terms of this license, please uninstall this package"
}

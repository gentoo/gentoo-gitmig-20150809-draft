# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.5.0.06-r1.ebuild,v 1.7 2006/10/17 23:49:12 nichoj Exp $

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="nostrip fetch"

inherit java-vm-2 versionator

PV_MAJOR="$(get_version_component_range 1-3 ${PV})"
PV_EXTRA="$(get_version_component_range 4 ${PV})"
HOMEPAGE_PV="$(delete_all_version_separators ${PV_MAJOR})_${PV_EXTRA}"
UPSTREAM_RELEASE="26.4.0"

SRC_URI_BASE="jrockit-R${UPSTREAM_RELEASE}-jdk${PV_MAJOR}_${PV_EXTRA}-linux-"
SRC_URI="x86? ( ${SRC_URI_BASE}ia32.bin )
		amd64? ( ${SRC_URI_BASE}x64.bin )
		ia64? ( ${SRC_URI_BASE}ipf.bin )"
DESCRIPTION="BEA WebLogic's J2SE Development Kit, R${UPSTREAM_RELEASE}"

HOMEPAGE="http://commerce.bea.com/products/weblogicjrockit/jrockit_prod_fam.jsp"

LICENSE="jrockit"
SLOT="1.5"
KEYWORDS="-* amd64 ia64 x86"
IUSE=""

DEPEND=">=app-arch/unzip-5.50-r1"
JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

QA_TEXTRELS_amd64="opt/${P}/mercuryprofiler/lib/sparc-sunos/libprobejni.so
	opt/${P}/mercuryprofiler/lib/x86-linux/libprobejni.so"

# not working for some reason...
QA_EXECSTACK_amd64="opt/${P}/mercuryprofiler/bin/sparc-sunos/systemmetrics
	opt/${P}/mercuryprofiler/lib/sparc-sunos/libprobejni.so"

pkg_nofetch() {
	einfo "Please download ${A} from:"
	einfo ${HOMEPAGE}
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	mkdir ${S}
	cd ${S}
	unzip ${DISTDIR}/${A} || die "Failed to unpack ${A}"

	for z in *.zip ; do
		unzip $z || die
		rm $z
	done
}

src_install() {
	#no man in this version
	local dirs="bin demo console include jre lib memleak mercuryprofiler sample src.zip"
	dodir /opt/${P}

	for i in ${dirs} ; do
		cp -R $i ${D}/opt/${P}/ || die
	done

	newdoc README.TXT README
	newdoc LICENSE LICENSE

	set_java_env
}

pkg_postinst () {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst
	einfo "Please review the license agreement in /usr/share/doc/${PF}/LICENSE"
	einfo "If you do not agree to the terms of this license, please uninstall this package"
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.5.0.10.ebuild,v 1.2 2007/07/02 14:33:55 peper Exp $

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="strip fetch"

inherit java-vm-2 versionator

PV_MAJOR="$(get_version_component_range 1-3 ${PV})"
PV_EXTRA="$(get_version_component_range 4 ${PV})"
UPSTREAM_RELEASE="27.2.0"

SRC_URI_BASE="jrockit-R${UPSTREAM_RELEASE}-jdk${PV_MAJOR}_${PV_EXTRA}-linux-"
SRC_URI="x86? ( ${SRC_URI_BASE}ia32.bin )
		amd64? ( ${SRC_URI_BASE}x64.bin )
		ia64? ( ${SRC_URI_BASE}ipf.bin )"
DESCRIPTION="BEA WebLogic's J2SE Development Kit, R${UPSTREAM_RELEASE}"

HOMEPAGE="http://commerce.bea.com/products/weblogicjrockit/jrockit_prod_fam.jsp"

LICENSE="jrockit"
SLOT="1.5"
KEYWORDS="-* ~amd64 ~ia64 ~x86"
IUSE="doc examples"

DEPEND="app-arch/unzip"
RDEPEND="doc? ( =dev-java/java-sdk-docs-1.5.0* )"
JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

QA_TEXTRELS_amd64="opt/${P}/mercuryprofiler/lib/sparc-sunos/libprobejni.so
	opt/${P}/mercuryprofiler/lib/x86-linux/libprobejni.so"

# not working for some reason...
# because it probably needs WX_LOAD and not EXECSTACK
QA_EXECSTACK_amd64="opt/${P}/mercuryprofiler/bin/sparc-sunos/systemmetrics
	opt/${P}/mercuryprofiler/lib/sparc-sunos/libprobejni.so"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/jrockit/libjvm.so
opt/${P}/jre/lib/i386/motif21/libmawt.so
opt/${P}/jre/lib/i386/libjmapi.so
opt/${P}/mercuryprofiler/lib/x86-linux/libjvmti.so
opt/${P}/mercuryprofiler/lib/x86-linux/libprobejni.so
opt/${P}/mercuryprofiler/lib/sparc-sunos64/libjvmti.so
opt/${P}/mercuryprofiler/lib/sparc-sunos64/libprobejni.so
opt/${P}/mercuryprofiler/lib/sparc-sunos/libjvmti.so
opt/${P}/mercuryprofiler/lib/sparc-sunos/libprobejni.so"

QA_EXECSTACK_x86="opt/${P}/bin/*
opt/${P}/jre/bin/*
opt/${P}/jre/lib/i386/jrockit/libjvm.so
opt/${P}/jre/lib/i386/libnet.so"

QA_WX_LOAD_x86="opt/${P}/mercuryprofiler/bin/sparc-sunos/systemmetrics
opt/${P}/mercuryprofiler/bin/sparc-sunos/reference_sort
opt/${P}/mercuryprofiler/lib/sparc-sunos64/libjvmti.so
opt/${P}/mercuryprofiler/lib/sparc-sunos64/libprobejni.so
opt/${P}/mercuryprofiler/lib/sparc-sunos/libjvmti.so
opt/${P}/mercuryprofiler/lib/sparc-sunos/libprobejni.so"

pkg_nofetch() {
	einfo "Please download ${A} from:"
	einfo ${HOMEPAGE}
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	# unpack cannot determine file format
	# unzip to get more zips
	unzip ${DISTDIR}/${A} || die

	mkdir ${S} || die

	# this is ugly but don't see any better way
	# empty jre dir is part of the zip
	unzip *sdk_no_jre.zip -d ${S} || die
	# remove so it doesn't affect next unzip
	rm *sdk_no_jre.zip || die
	# unpack the jre into its dir
	unzip *jre.zip -d ${S}/jre || die
}

src_install() {
	local dirs="bin include jre lib mercuryprofiler missioncontrol src.zip"

	insinto "/opt/${P}"
	for i in ${dirs} ; do
		doins -r $i || die
	done

	if use examples; then
		doins -r demo || die
		doins -r sample || die
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

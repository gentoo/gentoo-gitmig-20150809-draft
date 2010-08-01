# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/jrockit-jdk-bin/jrockit-jdk-bin-1.5.0.14.ebuild,v 1.4 2010/08/01 23:25:32 caster Exp $

# WARNING: This is the default VM on ia64, so treat this ebuild
# with proper care.

# NOTE: this version is special, because it's fetched from the security alert
# page which does not require licence click-through, has different URL, names...
# standard ebuild content is commented out

# The stripping of symbols seems to mess up the BEA code. Not sure why.
RESTRICT="strip mirror" #fetch

inherit java-vm-2 versionator

PV_MAJOR="$(get_version_component_range 1-3 ${PV})"
PV_EXTRA="$(get_version_component_range 4 ${PV})"
MY_PV="${PV_MAJOR}_${PV_EXTRA}"
UPSTREAM_RELEASE="27.5.0"

#SRC_URI_BASE="jrockit-R${UPSTREAM_RELEASE}-jdk${PV_MAJOR}_${PV_EXTRA}-linux-"
SRC_URI_BASE="ftp://anonymous:dev2dev%40bea%2Ecom@ftpna.bea.com/pub/releases/security/jrockit-R${UPSTREAM_RELEASE}-jdk${MY_PV}-linux-"
SRC_URI="ia64? ( ${SRC_URI_BASE}ipf.bin )
		amd64? ( ${SRC_URI_BASE}x64.bin )
		x86? ( ${SRC_URI_BASE}ia32.bin )"
DESCRIPTION="BEA WebLogic's J2SE Development Kit"

HOMEPAGE="http://commerce.bea.com/products/weblogicjrockit/jrockit_prod_fam.jsp"

LICENSE="jrockit"
SLOT="1.5"
KEYWORDS="-* ia64"
IUSE="X alsa doc examples odbc"

DEPEND="app-arch/unzip"
RDEPEND="sys-libs/glibc
	alsa? ( media-libs/alsa-lib )
	doc? ( =dev-java/java-sdk-docs-1.5.0* )
	X? (
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXp
			x11-libs/libXtst
			x11-libs/libXt
			x11-libs/libX11
			=dev-libs/glib-2*
			=x11-libs/gtk+-2*
	)
	odbc? ( dev-db/unixODBC )"

JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/jrockit/libjvm.so
opt/${P}/jre/lib/i386/motif21/libmawt.so
opt/${P}/jre/lib/i386/libjmapi.so"

QA_EXECSTACK_x86="opt/${P}/bin/*
opt/${P}/jre/bin/*
opt/${P}/jre/lib/i386/jrockit/libjvm.so
opt/${P}/jre/lib/i386/libnet.so"

#pkg_nofetch() {
#     einfo "Please download ${A} from:"
#     einfo ${HOMEPAGE}
#     einfo "and move it to ${DISTDIR}"
#}

src_unpack() {
	# unpack cannot determine file format
	# unzip to get more zips
	unzip "${DISTDIR}"/${A} || die

	mkdir "${S}" || die

	# this is ugly but don't see any better way
	# empty jre dir is part of the zip
	unzip *sdk_no_jre.zip -d "${S}" || die
	# remove so it doesn't affect next unzip
	rm *sdk_no_jre.zip || die
	# unpack the jre into its dir
	unzip *jre.zip -d "${S}"/jre || die
}

src_install() {
	local dirs="bin include jre lib missioncontrol src.zip"

	dodir "/opt/${P}"

	cp -pPR ${dirs} "${D}/opt/${P}/" || die "failed to copy"

	if use examples; then
		cp -pPR demo sample "${D}/opt/${P}/" || die "failed to copy"
	fi

	newdoc README.txt README || die
	dodoc LICENSE || die

	set_java_env
	java-vm_revdep-mask
}

pkg_postinst () {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	elog "Please review the license agreement in /usr/share/doc/${PF}/LICENSE"
	elog "If you do not agree to the terms of this license, please uninstall this package"
}

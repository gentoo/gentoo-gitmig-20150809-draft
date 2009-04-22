# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.4.2.13.ebuild,v 1.3 2009/04/22 14:29:57 ranger Exp $

inherit java-vm-2 eutils versionator

JDK_RELEASE=$(get_version_component_range 1-3)
SERVICE_RELEASE=$(get_version_component_range 4)
RPM_PV="${JDK_RELEASE}-${SERVICE_RELEASE}.0"

JRE_DIST_PREFIX="IBMJava2-JRE-${RPM_PV}"

X86_JRE_DIST="${JRE_DIST_PREFIX}.tgz"
# wonder why amd64 has this extra special AMD64 in its filename...
AMD64_JRE_DIST="IBMJava2-JRE-AMD64-${RPM_PV}.x86_64.tgz"
PPC_JRE_DIST="${JRE_DIST_PREFIX}.ppc.tgz"
PPC64_JRE_DIST="${JRE_DIST_PREFIX}.ppc64.tgz"

if use x86; then
	JRE_DIST=${X86_JRE_DIST}
	S="${WORKDIR}/IBMJava2-142"
	LINK_ARCH="ia32"
elif use amd64; then
	JRE_DIST=${AMD64_JRE_DIST}
	S="${WORKDIR}/IBMJava2-amd64-142"
	LINK_ARCH="amd64"
elif use ppc; then
	JRE_DIST=${PPC_JRE_DIST}
	S="${WORKDIR}/IBMJava2-ppc-142"
	LINK_ARCH="ip32"
elif use ppc64; then
	JRE_DIST=${PPC64_JRE_DIST}
	S="${WORKDIR}/IBMJava2-ppc64-142"
	LINK_ARCH="ip64"
fi

DIRECT_DOWNLOAD="https://www14.software.ibm.com/webapp/iwm/web/preLogin.do?source=lxdk&S_PKG=${LINK_ARCH}142sr${SERVICE_RELEASE}&cp=UTF-8&S_TACT=105AGX05&S_CMP=JDK"

DESCRIPTION="IBM Java Runtime Environment"
HOMEPAGE="http://www.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}linux/download.html"
ALT_DOWNLOADPAGE="${HOMEPAGE}linux/older_download.html"

SRC_URI="x86? ( ${X86_JRE_DIST} )
	amd64? ( ${AMD64_JRE_DIST} )
	ppc? ( ${PPC_JRE_DIST} )
	ppc64? ( ${PPC64_JRE_DIST} )"

LICENSE="IBM-J1.4"
SLOT="1.4"
KEYWORDS="-* amd64 ppc ppc64 x86"
IUSE="X alsa nsplugin"

RDEPEND="=virtual/libstdc++-3.3
	alsa? ( media-libs/alsa-lib )
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXmu
		x11-libs/libXp
		x11-libs/libXtst
		x11-libs/libXt
		x11-libs/libX11
	)"
DEPEND=""

RESTRICT="fetch"

QA_TEXTRELS_x86="opt/${P}/bin/lib*.so
	opt/${P}/bin/javaplugin.so
	opt/${P}/bin/classic/libjvm.so
	opt/${P}/bin/classic/libcore.so"
QA_TEXTRELS_amd64="
	opt/${P}/bin/j9vm/libj9jit23.so
	opt/${P}/bin/j9vm/libjclscar_23.so
	opt/${P}/bin/libj9jit22.so
	opt/${P}/bin/libjclscar_22.so
"

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${DOWNLOADPAGE}"

	einfo "Under Java 1.4.2, download SR${SERVICE_RELEASE} for your arch:"
	einfo "${JRE_DIST}"

	einfo "Direct link:"
	einfo "${DIRECT_DOWNLOAD}"
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then restart emerge: 'emerge --resume'"

	einfo "Note: if SR${SERVICE_RELEASE} is not available at ${DOWNLOADPAGE}"
	einfo "it may have been moved to ${ALT_DOWNLOADPAGE}. Lately that page"
	einfo "isn't updated, but the files should still available through the"
	einfo "direct link. If it doesn't work, file a bug."
}

src_compile() { :; }

src_install() {
	# javaws is on x86 only
	if use x86; then
		# The javaws execution script is 777 why?
		chmod 0755 "${S}"/jre/javaws/javaws

		# bug #147259
		dosym ../javaws/javaws /opt/${P}/bin/javaws
	fi

	# Copy all the files to the designated directory
	dodir /opt/${P}
	cp -pR "${S}"/jre/* "${D}"/opt/${P}/

	if use x86 && use nsplugin; then
		local plugin="libjavaplugin_oji.so"

		if has_version '>=sys-devel/gcc-3' ; then
			plugin="libjavaplugin_ojigcc3.so"
		fi

		install_mozilla_plugin /opt/${P}/bin/${plugin}
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc "${S}"/docs/COPYRIGHT

	set_java_env
	java-vm_revdep-mask
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.5.0.2.ebuild,v 1.2 2006/09/01 03:31:09 nichoj Exp $

inherit java-vm-2 versionator eutils rpm

JDK_RELEASE=$(get_version_component_range 2-3)
SERVICE_RELEASE=$(get_version_component_range 4)
RPM_PV="${JDK_RELEASE}-${SERVICE_RELEASE}.0"

X86_JDK_DIST="ibm-java2-i386-sdk-${RPM_PV}.i386.rpm"
X86_JAVACOMM_DIST="ibm-java2-i386-javacomm-${RPM_PV}.i386.rpm"

AMD64_JDK_DIST="ibm-java2-x86_64-sdk-${RPM_PV}.x86_64.rpm"
AMD64_JAVACOMM_DIST="ibm-java2-x86_64-javacomm-${RPM_PV}.x86_64.rpm"

PPC_JDK_DIST="ibm-java2-ppc-sdk-${RPM_PV}.ppc.rpm"
PPC_JAVACOMM_DIST="ibm-java2-ppc-javacomm-${RPM_PV}.ppc.rpm"

PPC64_JDK_DIST="ibm-java2-ppc64-sdk-${RPM_PV}.ppc64.rpm"
PPC64_JAVACOMM_DIST="ibm-java2-ppc64-javacomm-${RPM_PV}.ppc64.rpm"

if use x86; then
	JDK_DIST=${X86_JDK_DIST}
	JAVACOMM_DIST=${X86_JAVACOMM_DIST}
	S="${WORKDIR}/opt/ibm/java2-i386-50"
elif use amd64; then
	JDK_DIST=${AMD64_JDK_DIST}
	JAVACOMM_DIST=${AMD64_JAVACOMM_DIST}
	S="${WORKDIR}/opt/ibm/java2-x86_64-50"
elif use ppc; then
	JDK_DIST=${PPC_JDK_DIST}
	JAVACOMM_DIST=${PPC_JAVACOMM_DIST}
	S="${WORKDIR}/opt/ibm/java2-ppc-50"
elif use ppc64; then
	JDK_DIST=${PPC64_JDK_DIST}
	JAVACOMM_DIST=${PPC64_JAVACOMM_DIST}
	S="${WORKDIR}/opt/ibm/java2-ppc64-50"
fi

SLOT="1.5"
DESCRIPTION="IBM Java Development Kit ${SLOT}"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}/linux/download.html"
# bug #125178
ALT_DOWNLOADPAGE="${HOMEPAGE}/older_download.html"

SRC_URI="x86? ( ${X86_JDK_DIST} )
	amd64? ( ${AMD64_JDK_DIST} )
	ppc? ( ${PPC_JDK_DIST} )
	ppc64? ( ${PPC64_JDK_DIST} )
	javacomm? (
		x86? ( ${X86_JAVACOMM_DIST} )
		amd64? ( ${AMD64_JAVACOMM_DIST} )
		ppc? ( ${PPC_JAVACOMM_DIST} )
		ppc64? ( ${PPC64_JAVACOMM_DIST} )
		)"
LICENSE="IBM-J1.5"
KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
RESTRICT="fetch"

DEPEND="
		X? ( || (
					(
						x11-libs/libXt
						x11-libs/libX11
						x11-libs/libXtst
						x11-libs/libXp
						x11-libs/libXext
						x11-libs/libSM
						x11-libs/libICE
						x11-libs/libXau
						x11-libs/libXdmcp
						x11-libs/libXi
						x11-libs/libXmu
					)
					virtual/x11
				)
			)"
RDEPEND="${DEPEND}"

IUSE="X javacomm nsplugin"


pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${DOWNLOADPAGE}"

	einfo "Under J2SE 5.0, download SR${SERVICE_RELEASE}:"
	einfo "${JDK_DIST}"
	if use javacomm ; then
		einfo "${JAVACOMM_DIST}"
	fi
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then run emerge =${VMHANDLE}*"

	einfo "Note: if SR${SERVICE_RELEASE} is not available at ${DOWNLOADPAGE}"
	einfo "it may have been moved to ${ALT_DOWNLOADPAGE}"
}

src_compile() { :; }

src_install() {
	# Copy all the files to the designated directory
	mkdir -p ${D}opt/${P}
	cp -pR ${S}/{bin,jre,lib,include} ${D}opt/${P}/

	mkdir -p ${D}/opt/${P}/share
	cp -pPR ${S}/{demo,src.jar} ${D}opt/${P}/share/

	# setting the ppc stuff
	#if use ppc; then
	#	dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc.so
	#	dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc_g.so
	#	insinto /etc
	#	doins ${FILESDIR}/cpuinfo
	#fi

	if use nsplugin  && ! use amd64 && ! use ppc64; then
		local plugin
		if use x86; then
			plugin="libjavaplugin_ojigtk2.so"
		elif use ppc; then
			plugin="libjavaplugin_oji.so"
		fi
		install_mozilla_plugin /opt/${P}/jre/bin/${plugin}
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/COPYRIGHT

	set_java_env ${FILESDIR}/${VMHANDLE}

}

pkg_postinst() {
	java-vm-2_pkg_postinst
	if ! use X; then
		echo
		ewarn "You're not using X so its possible that you dont have"
		ewarn "a X server installed, please read the following warning: "
		ewarn "Some parts of IBM JDK require XFree86 to be installed."
		ewarn "Be careful which Java libraries you attempt to use."
	fi
}

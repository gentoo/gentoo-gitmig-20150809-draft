# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.5.0.3.ebuild,v 1.5 2006/10/18 03:20:20 nichoj Exp $

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
HOMEPAGE="http://www.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}linux/download.html"
# bug #125178
ALT_DOWNLOADPAGE="${HOMEPAGE}linux/older_download.html"

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
KEYWORDS="-* amd64 ppc ppc64 x86"
RESTRICT="fetch"

RDEPEND="
		=virtual/libstdc++-3.3
		X? ( || (
					(
						x11-libs/libXt
						x11-libs/libX11
						x11-libs/libXtst
						x11-libs/libXp
						x11-libs/libXext
						x11-libs/libXi
						x11-libs/libXmu
						x11-libs/libXft
					)
					virtual/x11
				)
			)
		alsa? ( media-libs/alsa-lib )
		nsplugin? (
			x86? ( =x11-libs/gtk+-2* =x11-libs/gtk+-1* )
			ppc? ( =x11-libs/gtk+-1* )
		)"
DEPEND=""

IUSE="X alsa javacomm nsplugin"

QA_EXECSTACK_amd64="opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libj9vrb23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9trc23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9shr23.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libj9jvmti23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9jit23.so
	opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libj9hookable23.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9dyn23.so
	opt/${P}/jre/bin/libj9dmp23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9bcv23.so
	opt/${P}/jre/bin/libiverel23.so
	opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/bin/j9vm/libjvm.so"

QA_TEXTRELS_amd64="opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libj9jit23.so"

QA_EXECSTACK_x86="opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/libj9jvmti23.so
	opt/${P}/jre/bin/libj9hookable23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9dyn23.so
	opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9dmp23.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libj9jit23.so
	opt/${P}/jre/bin/libiverel23.so
	opt/${P}/jre/bin/libj9trc23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libj9shr23.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9vrb23.so
	opt/${P}/jre/bin/libj9bcv23.so
	opt/${P}/jre/bin/libj9aotrt23.so
	opt/${P}/jre/bin/classic/libjvm.so"

QA_TEXTRELS_ppc="opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/libj9aotrt23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9gcchk23.so
	opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libj9jit23.so
	opt/${P}/jre/bin/libj9jitd23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9jvmti23.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9ute23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libjaas.so
	opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/libjsig.so
"

QA_TEXTRELS_ppc64="opt/${P}/jre/bin/libj9jextract.so
	opt/${P}/jre/bin/libjsig.so
	opt/${P}/jre/bin/libj9jitd23.so
	opt/${P}/jre/bin/libj9ute23.so
	opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/bin/libj9prt23.so
	opt/${P}/jre/bin/libjclscar_23.so
	opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/libj9gc23.so
	opt/${P}/jre/bin/libj9dbg23.so
	opt/${P}/jre/bin/libj9thr23.so
	opt/${P}/jre/bin/libj9jpi23.so
	opt/${P}/jre/bin/libj9gcchk23.so
	opt/${P}/jre/bin/libj9vm23.so
	opt/${P}/jre/bin/libj9jit23.so"


QA_TEXTRELS_x86="opt/${P}/jre/bin/lib*.so
	opt/${P}/jre/bin/j9vm/libjvm.so
	opt/${P}/jre/bin/xawt/libmawt.so
	opt/${P}/jre/bin/javaplugin.so
	opt/${P}/jre/bin/motif21/libmawt.so
	opt/${P}/jre/bin/headless/libmawt.so
	opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/lib/i386/libdeploy.so"

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
	einfo "If it's not even there, you can also try rewriting the link of the"
	einfo "newer SR# into SR${SERVICE_RELEASE}, while cursing IBM."
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


	local x86plugin=libjavaplugin_ojigtk2.so
	local ppcplugin=libjavaplugin_oji.so
	local jrebindest="${D}/opt/${P}/jre/bin/"

	local plugin
	if use x86; then
		plugin=${x86plugin}
	elif use ppc; then
		plugin=${ppcplugin}
	#	rm "${jrebindest}/${x86plugin}" "${jrebindest}/libjavaplugin_nscpgtk2.so" || \
	#		eerror "Failed to delete gtk2 javaplugin."
	fi

	plugin=/opt/${P}/jre/bin/${plugin}

	if use x86 || use ppc; then
		if use nsplugin; then
			install_mozilla_plugin ${plugin}
		else
			rm "${jrebindest}/*javaplugin*.so" || \
				eerror "Failed to delete javaplugin shared libraries"
		fi
	fi

	use !alsa && rm "${jrebindest}/libjsoundalsa.so"

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/COPYRIGHT

	set_java_env
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

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.4.2.6-r4.ebuild,v 1.2 2006/09/19 16:24:23 caster Exp $

JAVA_SUPPORTS_GENERATION_1="true"
inherit java-vm-2 eutils versionator rpm

JDK_RELEASE=$(get_version_component_range 1-3)
SERVICE_RELEASE=$(get_version_component_range 4)
RPM_PV="${JDK_RELEASE}-${SERVICE_RELEASE}.0"

if use x86 ; then
	JDK_DIST="IBMJava2-142-ia32-SDK-${RPM_PV}.i386.rpm"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-${RPM_PV}.i386.rpm"
	S="${WORKDIR}/opt/IBMJava2-142"
elif use amd64 ; then
	JDK_DIST="IBMJava2-AMD64-142-SDK-${RPM_PV}.x86_64.rpm"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-AMD64-${RPM_PV}.x86_64.rpm"
	S="${WORKDIR}/opt/IBMJava2-amd64-142"
elif use ppc ; then
	JDK_DIST="IBMJava2-142-ppc32-SDK-${RPM_PV}.ppc.rpm"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-${RPM_PV}.ppc.rpm"
	S="${WORKDIR}/opt/IBMJava2-ppc-142"
elif use ppc64 ; then
	JDK_DIST="IBMJava2-142-ppc64-SDK-${RPM_PV}.ppc64.rpm"
	JAVACOMM_DIST="IBMJava2-JAVACOMM-${RPM_PV}.ppc64.rpm"
	S="${WORKDIR}/opt/IBMJava2-ppc64-142"
elif use s390 ; then
	JDK_DIST="IBMJava2-142-z31-SDK-${RPM_PV}.s390.rpm"
	S="${WORKDIR}/opt/IBMJava2-s390-142"
fi

DESCRIPTION="IBM Java Development Kit"
HOMEPAGE="http://www.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}linux/download.html"
# bug #125178
ALT_DOWNLOADPAGE="${HOMEPAGE}linux/older_download.html"
SRC_URI="x86? ( IBMJava2-142-ia32-SDK-${RPM_PV}.i386.rpm )
		amd64? ( IBMJava2-AMD64-142-SDK-${RPM_PV}.x86_64.rpm )
		ppc? ( IBMJava2-142-ppc32-SDK-${RPM_PV}.ppc.rpm )
		ppc64? ( IBMJava2-142-ppc64-SDK-${RPM_PV}.ppc64.rpm )
		s390? ( IBMJava2-142-z31-SDK-${RPM_PV}.s390.rpm )
		javacomm? (
					x86? ( IBMJava2-JAVACOMM-${RPM_PV}.i386.rpm )
					amd64? ( IBMJava2-JAVACOMM-AMD64-${RPM_PV}.x86_64.rpm )
					ppc? ( IBMJava2-142-ppc32-SDK-${RPM_PV}.ppc.rpm )
					ppc64? ( IBMJava2-142-ppc64-SDK-${RPM_PV}.ppc64.rpm )
				  )"

LICENSE="IBM-J1.4"
SLOT="1.4"
KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
IUSE="X alsa doc javacomm nsplugin"

RDEPEND="
		ppc? ( sys-libs/lib-compat )
		alsa? ( media-libs/alsa-lib )
		X? (
			x11-libs/libXt
			x11-libs/libX11
			x11-libs/libXtst
			x11-libs/libXp
			x11-libs/libXext
			x11-libs/libXi
			x11-libs/libXmu
		)
		x86? ( nsplugin? ( =x11-libs/gtk+-1* =dev-libs/glib-1* ) )
		doc? ( =dev-java/java-sdk-docs-1.4.2* )"


RESTRICT="fetch"

QA_TEXTRELS_x86="opt/${P}/jre/bin/lib*.so
	opt/${P}/jre/bin/javaplugin.so
	opt/${P}/jre/bin/classic/libjvm.so
	opt/${P}/jre/bin/classic/libcore.so"

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${DOWNLOADPAGE}"

	einfo "Under Java 1.4.2, download SR${SERVICE_RELEASE} for your arch:"
	einfo "${JDK_DIST}"
	if use javacomm ; then
		einfo "${JAVACOMM_DIST}"
	fi
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then restart emerge: 'emerge --resume'"

	einfo "Note: if SR${SERVICE_RELEASE} is not available at ${DOWNLOADPAGE}"
	einfo "it may have been moved to ${ALT_DOWNLOADPAGE}"
}

src_compile() { true; }

src_install() {
	# javaws is on x86 only
	if use x86; then
		# The javaws execution script is 777 why?
		chmod 0755 ${S}/jre/javaws/javaws

		# bug #147259
		dosym ../jre/javaws/javaws /opt/${P}/bin/javaws
		dosym ../javaws/javaws /opt/${P}/jre/bin/javaws
	fi

	# Copy all the files to the designated directory
	mkdir -p ${D}opt/${P}
	cp -pR ${S}/{bin,jre,lib,include} ${D}opt/${P}/

	mkdir -p ${D}/opt/${P}/share
	cp -pPR ${S}/{demo,src.jar} ${D}opt/${P}/share/

	# setting the ppc stuff
	if use ppc; then
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc.so
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc_g.so
		insinto /etc
		doins ${FILESDIR}/cpuinfo
	fi

	if use x86 && use nsplugin; then
		local plugin="libjavaplugin_oji.so"

		if has_version '>=sys-devel/gcc-3' ; then
			plugin="libjavaplugin_ojigcc3.so"
		fi

		install_mozilla_plugin /opt/${P}/jre/bin/${plugin}
	elif use x86; then
		rm ${D}/opt/${P}/jre/bin/libjavaplugin*.so
	fi

	if ! use alsa; then
		rm ${D}/opt/${P}/jre/bin/libjsoundalsa.so \
			|| eerror "${D}/opt/${P}/jre/bin/libjsoundalsa.so not found"
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/docs/COPYRIGHT

	set_java_env
}

pkg_postinst() {
	java-vm-2_pkg_postinst

	if ! use X; then
		ewarn
		ewarn "You have not enabled the X useflag.  It is possible that"
		ewarn "you do not have an X server installed.  Please note that"
		ewarn "some parts of the IBM JDK require an X server to properly"
		ewarn "function.  Be careful which Java libraries you attempt to"
		ewarn "use with your installation."
		ewarn
	fi
}

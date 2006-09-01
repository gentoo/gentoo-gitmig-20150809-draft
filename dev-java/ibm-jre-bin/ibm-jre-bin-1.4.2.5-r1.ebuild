# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jre-bin/ibm-jre-bin-1.4.2.5-r1.ebuild,v 1.1 2006/09/01 03:35:33 nichoj Exp $

inherit java-vm-2 eutils versionator rpm

JDK_RELEASE=$(get_version_component_range 1-3)
SERVICE_RELEASE=$(get_version_component_range 4)
RPM_PV="${JDK_RELEASE}-${SERVICE_RELEASE}.0"

if use x86 ; then
	JRE_DIST="IBMJava2-142-ia32-JRE-${RPM_PV}.i386.rpm"
elif use amd64 ; then
	JRE_DIST="IBMJava2-AMD64-142-JRE-${RPM_PV}.x86_64.rpm"
elif use ppc ; then
	JRE_DIST="IBMJava2-142-ppc32-JRE-${RPM_PV}.ppc.rpm"
elif use ppc64 ; then
	JRE_DIST="IBMJava2-142-ppc64-JRE-${RPM_PV}.ppc64.rpm"
fi

DESCRIPTION="IBM Java Development Kit"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
DOWNLOADPAGE="${HOMEPAGE}/linux/download.html"

SRC_URI="x86? ( IBMJava2-142-ia32-JRE-${RPM_PV}.i386.rpm )
		 amd64? ( IBMJava2-AMD64-142-JRE-${RPM_PV}.x86_64.rpm )
		 ppc? ( IBMJava2-142-ppc32-JRE-${RPM_PV}.ppc.rpm )
		 ppc64? ( IBMJava2-142-ppc64-JRE-${RPM_PV}.ppc64.rpm )"

LICENSE="IBM-J1.4"
SLOT="1.4"
KEYWORDS="-* ~amd64 ~ppc ~ppc64 ~x86"
IUSE="X nsplugin"

DEPEND="X? ( || (
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
RDEPEND="${DEPEND}
		 !ppc64? ( !amd64? ( sys-libs/lib-compat ) )"


RESTRICT="fetch"

if use ppc; then
	S="${WORKDIR}/opt/IBMJava2-ppc-142"
elif use ppc64; then
	S="${WORKDIR}/opt/IBMJava2-ppc64-142"
elif use amd64; then
	S="${WORKDIR}/opt/IBMJava2-amd64-142"
else
	S="${WORKDIR}/opt/IBMJava2-142"
fi

pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${DOWNLOADPAGE}"

	einfo "Under Java 1.4.2, download SR${SERVICE_RELEASE}:"
	einfo "${JRE_DIST}"
	einfo "Place the file(s) in: ${DISTDIR}"
	einfo "Then run emerge =${VMHANDLE}*"

	einfo "Note: if SR${SERVICE_RELEASE} is not available at ${DOWNLOADPAGE}"
	einfo "it may have been moved to ${ALT_DOWNLOADPAGE}"
}

src_compile() { :; }

src_install() {
	# The javaws execution script is 777 why?
	chmod 0755 ${S}/jre/javaws/javaws

	# Copy all the files to the designated directory
	dodir /opt/${P}
	cp -pR ${S}/jre/* ${D}opt/${P}/

	if use nsplugin && ! use ppc && ! use amd64 && ! use ppc64; then
		local plugin="libjavaplugin_oji.so"

		if has_version '>=sys-devel/gcc-3' ; then
			plugin="libjavaplugin_ojigcc3.so"
		fi

		install_mozilla_plugin /opt/${P}/bin/${plugin}
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/docs/COPYRIGHT

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst() {
	java-vm-2_pkg_postinst

	if ! use X; then
		ewarn
		ewarn "You have not enabled the X useflag.  It is possible that"
		ewarn "you do not have an X server installed.  Please note that"
		ewarn "some parts of the IBM JRE require an X server to properly"
		ewarn "function.  Be careful which Java libraries you attempt to"
		ewarn "use with your installation."
		ewarn
	fi
}

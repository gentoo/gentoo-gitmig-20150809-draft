# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.4.2.ebuild,v 1.26 2005/08/26 13:04:32 flameeyes Exp $

inherit java eutils

DESCRIPTION="IBM Java Development Kit ${PV}"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
SRC_URI="ppc? ( mirror://gentoo/IBMJava2-SDK-142.ppc.tgz )
	ppc64? ( mirror://gentoo/IBMJava2-SDK-142.ppc64.tgz )
	x86? ( mirror://gentoo/IBMJava2-SDK-142.tgz )
	amd64? ( mirror://gentoo/IBMJava2-SDK-AMD64-142.x86_64.tgz )
	javacomm? (
		x86? ( mirror://gentoo/IBMJava2-JAVACOMM-142.tgz )
		ppc64? ( mirror://gentoo/IBMJava2-JAVACOMM-142.tgz )
		amd64? ( mirror://gentoo/IBMJava2-JAVACOMM-AMD64-142.x86_64.tgz )
		)"
PROVIDE="virtual/jdk
	virtual/jre"
SLOT="1.4"
LICENSE="IBM-J1.4"
KEYWORDS="ppc ~x86 ppc64 amd64 -*"

DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.4.2* )
	X? ( virtual/x11 )"
RDEPEND="${DEPEND}
	!ppc64? ( !amd64? ( sys-libs/lib-compat ) )"

IUSE="X doc javacomm browserplugin mozilla"

if use ppc; then
	S="${WORKDIR}/IBMJava2-ppc-142"
elif use ppc64; then
	S="${WORKDIR}/IBMJava2-ppc64-142"
elif use amd64; then
	S="${WORKDIR}/IBMJava2-amd64-142"
else
	S="${WORKDIR}/IBMJava2-142"
fi

src_compile() { :; }

src_install() {
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

	if ( use browserplugin || use mozilla ) && ! use ppc && ! use amd64 && ! use ppc64; then
		local plugin="libjavaplugin_oji.so"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin="libjavaplugin_ojigcc3.so"
		fi
		install_mozilla_plugin /opt/${P}/jre/bin/${plugin}
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/docs/COPYRIGHT

	set_java_env ${FILESDIR}/${VMHANDLE}

}

pkg_postinst() {
	java_pkg_postinst
	if ! use X; then
		echo
		eerror "You're not using X so its possible that you dont have"
		eerror "a X server installed, please read the following warning: "
		eerror "Some parts of IBM JDK require XFree86 to be installed."
		eerror "Be careful which Java libraries you attempt to use."
	fi
	if ! use browserplugin && use mozilla; then
		ewarn
		ewarn "The 'mozilla' useflag to enable the java browser plugin for applets"
		ewarn "has been renamed to 'browserplugin' please update your USE"
	fi

}

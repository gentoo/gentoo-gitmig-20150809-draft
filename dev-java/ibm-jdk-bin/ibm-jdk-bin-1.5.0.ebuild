# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.5.0.ebuild,v 1.2 2006/01/14 23:33:05 nichoj Exp $

inherit java eutils

DESCRIPTION="IBM Java Development Kit ${PV}"
HOMEPAGE="http://www-106.ibm.com/developerworks/java/jdk/"
SRC_URI="x86? ( ibm-java2-sdk-50-linux-i386.tgz )
	amd64? ( ibm-java2-sdk-50-linux-x86_64.tgz )
	ppc? ( ibm-java2-sdk-50-linux-ppc.tgz )
	javacomm? (
		x86? ( ibm-java2-javacomm-50-linux-i386.tgz )
		amd64? ( ibm-java2-javacomm-50-linux-x86_64.tgz )
		ppc? ( ibm-java2-javacomm-50-linux-ppc.tgz )
		)"
#	ppc64? ( ibm-java2-sdk-50-linux-ppc64.tgz )
#		ppc64? ( ibm-java2-javacomm-50-linux-ppc64.tgz )
PROVIDE="virtual/jdk
	virtual/jre"
SLOT="1.5"
LICENSE="IBM-J1.5"
KEYWORDS="~amd64 ~ppc ~x86 -*"
RESTRICT="fetch"

DEPEND="virtual/libc
	X? ( virtual/x11 )"
RDEPEND="${DEPEND}"

IUSE="X javacomm browserplugin mozilla"

if use x86; then
	S="${WORKDIR}/ibm-java2-i386-50"
elif use amd64; then
	S="${WORKDIR}/ibm-java2-x86_64-50"
elif use ppc; then
	S="${WORKDIR}/ibm-java2-ppc-50"
elif use ppc64; then
	S="${WORKDIR}/ibm-java2-ppc64-50"
fi


pkg_nofetch() {
	einfo "Due to license restrictions, we cannot redistribute or fetch the distfiles"
	einfo "Please visit: ${HOMEPAGE}"
	einfo "Download: ${A}"
	einfo "Place the file in: ${DISTDIR}"
	einfo "Rerun emerge"
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

	if ( use browserplugin || use mozilla ) && ! use amd64 && ! use ppc64; then
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

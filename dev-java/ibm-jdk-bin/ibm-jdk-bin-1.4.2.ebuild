# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk-bin/ibm-jdk-bin-1.4.2.ebuild,v 1.7 2004/07/24 21:51:26 mr_bones_ Exp $

IUSE="X doc javacomm"

inherit java nsplugins

if use ppc; then
	S="${WORKDIR}/IBMJava2-ppc-142"
elif use ppc64; then
	S="${WORKDIR}/IBMJava2-ppc64-142"
else
	S="${WORKDIR}/IBMJava2-142"
fi

DESCRIPTION="IBM Java Development Kit ${PV}"
SRC_URI="ppc? ( mirror://IBMJava2-SDK-142.ppc.tgz )
	ppc64? ( mirror://IBMJava2-SDK-142.ppc64.tgz )
	x86? ( mirror://IBMJava2-SDK-142.tgz )
	javacomm? (
		x86? ( mirror://IBMJava2-JAVACOMM-142.tgz )
		ppc64? ( mirror://IBMJava2-JAVACOMM-142.tgz )
		)"
PROVIDE="virtual/jdk-1.4.2
	virtual/jre-1.4.2
	virtual/java-scheme-2"
SLOT="1.4"
LICENSE="IBM-J1.4"
KEYWORDS="~ppc ~x86"

DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.4.1* )
	X? ( virtual/x11 )"
RDEPEND=" !ppc64? sys-libs/lib-compat"

# No compilation needed!
src_compile() { :; }

src_install() {
	# Copy all the files to the designated directory
	mkdir -p ${D}opt/${P}
	cp -dpR ${S}/{bin,jre,lib,include} ${D}opt/${P}/

	mkdir -p ${D}/opt/${P}/share
	cp -a ${S}/{demo,src.jar} ${D}opt/${P}/share/

	# setting the ppc stuff
	if use ppc; then
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc.so
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc_g.so
		insinto /etc
		doins ${FILESDIR}/cpuinfo
	else
		# No java-plugin on ppc
		inst_plugin /opt/${P}/jre/bin/libjavaplugin_oji.so
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc ${S}/docs/COPYRIGHT

	set_java_env ${FILESDIR}/${VMHANDLE}

}

pkg_postinst() {
	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jdk 1.2.2 ebuild that he sent.
	if ! use X; then
		einfo "********************************************************"
		eerror "You're not using X so its possible that you dont have"
		eerror "a X server installed, please read the following warning: "
		eerror "Some parts of IBM JDK require XFree86 to be installed."
		eerror "Be careful which Java libraries you attempt to use."
		einfo "********************************************************"
		echo
	fi

	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	einfo " After installing ${P} this"
	einfo " was set as the default JVM to run."
	einfo " When finished please run the following so your"
	einfo " enviroment gets updated."
	eerror "    /usr/sbin/env-update && source /etc/profile"
	einfo " Or use java-config program to set your preferred VM"
	einfo "******************************************************"

	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	echo -ne "\a" ; sleep 0.1 &>/dev/null ; sleep 0,1 &>/dev/null
	echo -ne "\a" ; sleep 1
	sleep 8
}

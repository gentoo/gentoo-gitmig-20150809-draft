# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk/ibm-jdk-1.3.1-r3.ebuild,v 1.7 2004/03/18 05:51:32 zx Exp $

IUSE="doc"

inherit java nsplugins

if [ `use ppc` ]; then
	S=${WORKDIR}/IBMJava2-ppc-131
else
	S=${WORKDIR}/IBMJava2-131
fi;
DESCRIPTION="IBM JDK 1.3.1"

if [ `use ppc` ]; then
	SRC_JAVA="IBMJava2-SDK-131.ppc.tgz"
else
	SRC_JAVA="IBMJava2-SDK-131.tgz"
fi;

HOMEPAGE="https://www6.software.ibm.com/dl/lxdk/lxdk-p"
SRC_URI="${SRC_JAVA}"
DEPEND="virtual/glibc
		>=dev-java/java-config-0.2.5
		doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RESTRICT="fetch"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/jdk-1.3.1
	virtual/java-scheme-2"
LICENSE="IBM-ILNWP"
SLOT="1.3"
KEYWORDS="x86 ppc"

pkg_nofetch() {
	einfo "Download 32-bit pSeries and iSeries for PPC."
	einfo "Download 32-bit xSeries for x86."
	die "Please download ${SRC_URI} from ${HOMEPAGE} to ${DISTDIR}"
}

src_compile() { :; }

src_install() {

	dodir /opt/${P}
	for i in bin include jre lib ; do
		cp -dpR $i ${D}/opt/${P}/
	done

	dodir /opt/${P}/share
	for i in demo src.jar ; do
		cp -dpR $i ${D}/opt/${P}/share/
	done

	dohtml -a html,htm,HTML -r docs
	dodoc COPYRIGHT

	# Plugin is disabled as it crashes all the time
	## inst_plugin /opt/${P}/jre/bin/libjavaplugin_oji.so

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst() {

	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jdk 1.2.2 ebuild that he sent.
	if [ !"`use X`" ] ; then
		einfo "********************************************************"
		eerror "You're not using X so its possible that you dont have"
		eerror "a X server installed, please read the following warn: "
		eerror "Some parts of Sun's JDK require XFree86 to be installed."
		eerror "Be careful which Java libraries you attempt to use."
		einfo "********************************************************"
		echo
	fi

	einfo "******************************************************"
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
# NOTE: We don't install the plugin, as it always segfaults.

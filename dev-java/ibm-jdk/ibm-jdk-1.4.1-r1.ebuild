# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk/ibm-jdk-1.4.1-r1.ebuild,v 1.2 2004/04/07 03:33:22 zx Exp $

inherit java nsplugins

DESCRIPTION="IBM Java Development Kit, version 1.4.1"
HOMEPAGE="https://www6.software.ibm.com/dl/lxdk/lxdk-p"
SRC_URI="x86? ( IBMJava2-SDK-142.tgz )
		ppc? ( IBMJava2-SDK-141.ppc.tgz )"
RESTRICT="fetch"
SLOT="1.4"
LICENSE="IBM-ILNWP"
KEYWORDS="x86 ppc -sparc -alpha -mips"
IUSE="doc"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.4.1* )
	X? ( virtual/x11 )"
RDEPEND="sys-libs/lib-compat"
PROVIDE="virtual/jre-1.4.1
	virtual/jdk-1.4.1
	virtual/java-scheme-2"

if [ `use ppc` ]; then
	S=${WORKDIR}/IBMJava2-ppc-141
else
	S=${WORKDIR}/IBMJava2-141
fi;

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

	if [ `use ppc` ]; then
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc.so
		dosed s:/proc/cpuinfo:/etc//cpuinfo:g /opt/${P}/jre/bin/libjitc_g.so
		insinto /etc
		doins ${FILESDIR}/cpuinfo
	fi

	dohtml -a html,htm,HTML -r docs
	dodoc docs/COPYRIGHT

	inst_plugin /opt/${P}/jre/bin/libjavaplugin_oji.so

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst() {

	#Thanks to Douglas Pollock <douglas.pollock@magma.ca> for this
	#comment found on the sun-jdk 1.2.2 ebuild that he sent.
	if [ !`use X` ] ; then
		einfo "********************************************************"
		eerror "You're not using X so its possible that you dont have"
		eerror "a X server installed, please read the following warn: "
		eerror "Some parts of IBM JDK require XFree86 to be installed."
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

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk/ibm-jdk-1.4.1.ebuild,v 1.1 2003/06/25 07:00:00 pylon Exp $

IUSE="doc"

inherit java nsplugins

if [ `use ppc` ]; then
	S=${WORKDIR}/IBMJava2-ppc-141
else
	S=${WORKDIR}/IBMJava2-141
fi;
DESCRIPTION="IBM JDK 1.4.1"
SRC_UI=""

if [ `use ppc` ]; then
	SRC_JAVA="IBMJava2-SDK-141.ppc.tgz"
else
	SRC_JAVA="IBMJava2-SDK-141.tgz"
fi;

HOMEPAGE="https://www6.software.ibm.com/dl/lxdk/lxdk-p"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.4.1* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.4.1
	virtual/jdk-1.4.1
	virtual/java-scheme-2"
LICENSE="IBM-ILNWP"
SLOT="1.4.1"
KEYWORDS="~ppc"

src_unpack() {
	if [ ! -f ${DISTDIR}/${SRC_JAVA} ] ; then
		einfo "Download 32-bit pSeries and iSeries for PPC."
		einfo "Download 32-bit xSeries for x86."
		die "Please download ${SRC_JAVA} from ${HOMEPAGE} to ${DISTDIR}"
	fi
	unpack ${SRC_JAVA} || die
}

src_install () {

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

	einfo "*******************************************"
	einfo "To set ${P} as the default JVM run"
	einfo "java-config --set-system-vm=ibm-jdk-1.4.1"
	einfo "Then run env-update and logout and back in."
	einfo "*******************************************"
}

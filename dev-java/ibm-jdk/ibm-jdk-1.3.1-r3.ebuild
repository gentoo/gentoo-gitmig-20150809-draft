# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk/ibm-jdk-1.3.1-r3.ebuild,v 1.3 2003/09/08 07:20:54 msterret Exp $

IUSE="doc"

inherit java nsplugins

if [ `use ppc` ]; then
	S=${WORKDIR}/IBMJava2-ppc-131
else
	S=${WORKDIR}/IBMJava2-131
fi;
DESCRIPTION="IBM JDK 1.3.1"
SRC_UI=""

if [ `use ppc` ]; then
	SRC_JAVA="IBMJava2-SDK-131.ppc.tgz"
else
	SRC_JAVA="IBMJava2-SDK-131.tgz"
fi;

HOMEPAGE="https://www6.software.ibm.com/dl/lxdk/lxdk-p"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/jdk-1.3.1
	virtual/java-scheme-2"
LICENSE="IBM-ILNWP"
SLOT="1.3"
KEYWORDS="ppc"

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

	dohtml -a html,htm,HTML -r docs
	dodoc COPYRIGHT

	# Plugin is disabled as it crashes all the time
	## inst_plugin /opt/${P}/jre/bin/libjavaplugin_oji.so

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst() {

	einfo "*******************************************"
	einfo "To set ${P} as the default JVM run"
	einfo "java-config --set-system-vm=ibm-jdk-1.3.1"
	einfo "Then run env-update and logout and back in."
	einfo "*******************************************"
}

# NOTE: We don't install the plugin, as it always segfaults.

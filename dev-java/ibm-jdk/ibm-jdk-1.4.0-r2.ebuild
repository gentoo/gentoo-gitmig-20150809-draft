# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/ibm-jdk/ibm-jdk-1.4.0-r2.ebuild,v 1.3 2003/05/20 03:36:53 tberman Exp $

IUSE="doc"

inherit java nsplugins

At="IBMJava2-SDK-14.tgz"
S="${WORKDIR}/IBMJava2-14"
DESCRIPTION="IBM JDK 1.4.0"
SRC_URI=""
HOMEPAGE="https://www6.software.ibm.com/dl/lxdk/lxdk-p"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.4* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.4
	virtual/jdk-1.4
	virtual/java-scheme-2"
LICENSE="IBM-ILNWP"
SLOT="1.4"
KEYWORDS="x86 -ppc -sparc -alpha"

src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	unpack ${At} || die
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
	dodoc docs/COPYRIGHT

	inst_plugin /opt/${P}/jre/bin/libjavaplugin_oji.so
	set_java_env ${FILESDIR}/${VMHANDLE}
}


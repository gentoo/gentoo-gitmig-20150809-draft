# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/compaq-jdk/compaq-jdk-1.3.1.ebuild,v 1.6 2003/05/09 19:54:41 taviso Exp $

IUSE="doc"

inherit java 

At="jdk-1.3.1-1-linux-alpha.tgz"
S=${WORKDIR}/jdk1.3.1
SRC_URI=""
DESCRIPTION="Compaq Java Development Kit 1.3.1 for Alpha/Linux/GNU"
HOMEPAGE="http://h18012.www1.hp.com/java/documentation/1.3.1/linux/docs/index.html"
DEPEND="virtual/glibc
	app-arch/rpm2targz
    dev-libs/libots
    dev-libs/libcpml
	>=dev-java/java-config-0.2.5
	>=x11-libs/openmotif-2.1.30-r1
	doc? ( ~dev-java/java-sdk-docs-1.3.1 )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/jdk-1.3.1
	virtual/java-scheme-2"
LICENSE="compaq-sdla"
SLOT="1.3"
KEYWORDS="-x86 -ppc -sparc alpha"
	
src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	tar zxf ${DISTDIR}/${At}
	rpm2targz jdk-1.3.1-1-linux-alpha.rpm
	tar zxf jdk-1.3.1-1-linux-alpha.tar.gz >& /dev/null
	mv usr/java/jdk1.3.1 . 
}

src_install () {
	local dirs="bin include include-old jre lib"
	dodir /opt/${P}
	
	
	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	dodoc COPYRIGHT README LICENSE
	dohtml README.html

	doman man/man1/*.1

	dodir /opt/${P}/share/
	cp -a demo src.jar ${D}/opt/${P}/share/

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {                                                               
	# Set as default VM if none exists
	java_pkg_postinst
}                                                                             
                                                                            

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.3.1-r8.ebuild,v 1.5 2003/05/24 06:35:35 absinthe Exp $

IUSE="doc"

inherit java nsplugins

S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Blackdown Java Development Kit 1.3.1"
SRC_URI="x86? ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/i386/FCS/j2sdk-1.3.1-FCS-linux-i386.tar.bz2
	ppc? ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/ppc/FCS-02b/j2sdk-1.3.1-02b-FCS-linux-ppc.bin
	sparc? ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.3.1/sparc/FCS-02b/j2sdk-1.3.1-02b-FCS-linux-sparc.bin"

HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5
	doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jdk-1.3.1
	virtual/jre-1.3.1
	virtual/java-scheme-2"
SLOT="1.3"
LICENSE="sun-bcla-java-vm"
KEYWORDS="~x86 ~ppc ~sparc"

src_unpack () {
	if (use ppc) || (use sparc) ; then
		tail +400 ${DISTDIR}/${A} | tar xjf -
	else
		unpack ${A}
	fi

	if (use sparc) ; then
		# Everything is owned by 1000.100, for some reason..
		chown -R root.root .
	fi
}


src_install () {

	dodir /opt/${P}

	cp -dpR ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src.jar} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install ns plugin
	if [ "${ARCH}" == "x86" ] ; then
		PLATFORM="i386"
	elif [ "${ARCH}" == "ppc" ] ; then
		PLATFORM="ppc"
	elif [ "${ARCH}" == "sparc" ] ; then
		PLATFORM="sparc"
	fi

	inst_plugin /opt/${P}/jre/plugin/${PLATFORM}/mozilla/javaplugin_oji.so 

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	mv ${D}/opt/${P}/jre/lib/font.properties ${D}/opt/${P}/jre/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/jre/lib/font.properties.orig \
		> ${D}/opt/${P}/jre/lib/font.properties
	rm ${D}/opt/${P}/jre/lib/font.properties.orig
	
	# install env into /etc/env.d
	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {
	# Set as default system VM if none exists
	java_pkg_postinst
}


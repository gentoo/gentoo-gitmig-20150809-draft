# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.4.1_beta-r1.ebuild,v 1.4 2002/12/15 19:54:40 strider Exp $

inherit java nsplugins

S="${WORKDIR}/j2sdk1.4.1"
DESCRIPTION="Blackdown Java Development Kit 1.4.1 Beta"
SRC_URI="x86? ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.4.1/i386/beta/j2sdk-1.4.1-beta-linux-i586.bin
	sparc? ftp://metalab.unc.edu/pub/linux/devel/lang/java/blackdown.org/JDK-1.4.1/sparc/beta/j2sdk-1.4.1-beta-linux-sparc.bin"

HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.6
	doc? ( =dev-java/java-sdk-docs-1.4.1* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jdk-1.4.1
	virtual/jre-1.4.1
	virtual/java-scheme-2"
SLOT="1.4.1"
LICENSE="sun-bcla"
KEYWORDS="~x86 -ppc ~sparc"
IUSE="doc"

src_unpack () {
	tail +350 ${DISTDIR}/${A} | tar --no-same-owner -jxp
}


src_install () {

	dodir /opt/${P}

	cp -dpR ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src}.{jar,zip} ${D}/opt/${P}/share
	
	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	if [ "${ARCH}" == "x86" ] ; then
		PLATFORM="i386"
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


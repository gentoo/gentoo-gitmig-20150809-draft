# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.4.1.ebuild,v 1.1 2003/02/18 10:05:00 cretin Exp $

inherit java nsplugins gcc

S="${WORKDIR}/j2sdk1.4.1"
DESCRIPTION="Blackdown Java Development Kit 1.4.1"

if [ "`gcc-major-version`" -eq "3" -a "`gcc-minor-version`" -ge "2" ]
then
	SRC_URI="x86? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2sdk-1.4.1-01-linux-i586-gcc3.2.bin
	 sparc? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/sparc/01/j2sdk-1.4.1-01-linux-sparc-gcc3.2.bin"
else
	SRC_URI="x86? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2sdk-1.4.1-01-linux-i586-gcc2.95.bin
	sparc? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/sparc/01/j2sdk-1.4.1-01-linux-sparc-gcc3.2.bin"
	use sparc && RDEPEND=">=sys-devel/gcc-3.2"
fi

HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.6
	doc? ( =dev-java/java-sdk-docs-1.4.1* )"
RDEPEND="$RDEPEND $DEPEND"
PROVIDE="virtual/jdk-1.4.1
	virtual/jre-1.4.1
	virtual/java-scheme-2"
SLOT="1.4.1"
LICENSE="sun-bcla"
KEYWORDS="~x86 -ppc ~sparc"
IUSE="doc"

src_unpack () {
	tail +522 ${DISTDIR}/${A} | tar --no-same-owner -jxp || die "Corrupted file ${A}"
}


src_install () {

	dodir /opt/${P}

	cp -a ${S}/{bin,jre,lib,man,include} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -a ${S}/{demo,src.zip} ${D}/opt/${P}/share
	
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


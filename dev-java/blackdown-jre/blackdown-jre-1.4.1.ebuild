# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.4.1.ebuild,v 1.8 2004/03/18 06:33:56 zx Exp $

inherit java nsplugins gcc

S=${WORKDIR}/j2re1.4.1
DESCRIPTION="Blackdown Java Runtime Environment 1.4.1"

if [ "`gcc-major-version`" -eq "3" -a "`gcc-minor-version`" -ge "2" ]
then
	SRC_URI="x86? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc3.2.bin
	amd64? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc3.2.bin
	sparc? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/sparc/01/j2re-1.4.1-01-linux-sparc-gcc3.2.bin"
else
	SRC_URI="x86? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc2.95.bin
	amd64? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc3.2.bin
	sparc? http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/sparc/01/j2re-1.4.1-01-linux-sparc-gcc3.2.bin"
	use sparc && RDEPEND=">=sys-devel/gcc-3.2"
	use amd64 && RDEPEND=">=sys-devel/gcc-3.2"
fi

HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-1 )
	>=dev-java/java-config-0.2.5"
RDEPEND="$RDEPEND $DEPEND"
PROVIDE="virtual/jre-1.4.1
	virtual/java-scheme-2"
SLOT="0"
LICENSE="sun-bcla-java-vm"
KEYWORDS="x86 sparc amd64"

src_unpack () {
	tail -n +461 ${DISTDIR}/${A} | tar xjf -
}

src_install () {
	dodir /opt/${P}

	cp -a ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	if [ "${ARCH}" == "x86" ] ; then
		PLATFORM="i386"
	elif [ "${ARCH}" == "amd64" ] ; then
		PLATFORM="i386"
	elif [ "${ARCH}" == "ppc" ] ; then
		PLATFORM="ppc"
	elif [ "${ARCH}" == "sparc" ] ; then
		PLATFORM="sparc"
	fi
	inst_plugin /opt/${P}/plugin/${PLATFORM}/mozilla/javaplugin_oji.so

	mv ${D}/opt/${P}/lib/font.properties ${D}/opt/${P}/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/lib/font.properties.orig \
		> ${D}/opt/${P}/lib/font.properties
	rm ${D}/opt/${P}/lib/font.properties.orig

	set_java_env ${FILESDIR}/${VMHANDLE}

	# Fix for bug #26629.
	if [ "${PROFILE_ARCH}" = "sparc64" ]
	then
		sed -i -e 's/\/\//\/sparc\//g' \
			${D}/etc/env.d/java/20blackdown-jre-1.4.1
	fi
}

pkg_postinst () {
	java_pkg_postinst
}


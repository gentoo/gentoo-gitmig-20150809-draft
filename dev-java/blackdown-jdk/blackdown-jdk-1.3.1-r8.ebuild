# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.3.1-r8.ebuild,v 1.27 2006/07/01 20:00:41 betelgeuse Exp $

inherit java

S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Blackdown Java Development Kit 1.3.1"
HOMEPAGE="http://www.blackdown.org"
SRC_URI="x86? ( mirror://blackdown.org/JDK-${PV}/i386/FCS/j2sdk-${PV}-FCS-linux-i386.tar.bz2 )
	ppc? ( mirror://blackdown.org/JDK-${PV}/ppc/FCS-02b/j2sdk-${PV}-02b-FCS-linux-ppc.bin )
	sparc? ( mirror://blackdown.org/JDK-${PV}/sparc/FCS-02b/j2sdk-${PV}-02b-FCS-linux-sparc.bin )"

LICENSE="sun-bcla-java-vm"
SLOT="1.3"
KEYWORDS="x86 ~ppc sparc -*"
IUSE="doc browserplugin nsplugin mozilla"

DEPEND="doc? ( =dev-java/java-sdk-docs-1.3.1* )"

PROVIDE="virtual/jdk
	virtual/jre"

src_unpack() {
	if use ppc || use sparc ; then
		tail -n +400 ${DISTDIR}/${A} | tar jxpf -
	else
		unpack ${A}
	fi

	if use sparc ; then
		# Everything is owned by 1000.100, for some reason..
		chown -R root:root .
	fi
}


src_install() {

	dodir /opt/${P}

	cp -dpR ${S}/{bin,jre,lib,man,include,include-old} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -R ${S}/{demo,src.jar} ${D}/opt/${P}/share

	dodoc README
	dohtml README.html

	if use nsplugin ||       # global useflag for netscape-compat plugins
	   use browserplugin ||  # deprecated but honor for now
	   use mozilla; then     # wrong but used to honor it
		if [ "${ARCH}" == "x86" ] ; then
			PLATFORM="i386"
		elif [ "${ARCH}" == "ppc" ] ; then
			PLATFORM="ppc"
		elif [ "${ARCH}" == "sparc" ] ; then
			PLATFORM="sparc"
		fi

		install_mozilla_plugin /opt/${P}/jre/plugin/${PLATFORM}/mozilla/javaplugin_oji.so
	fi

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	mv ${D}/opt/${P}/jre/lib/font.properties ${D}/opt/${P}/jre/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/jre/lib/font.properties.orig \
		> ${D}/opt/${P}/jre/lib/font.properties
	rm ${D}/opt/${P}/jre/lib/font.properties.orig

	# install env into /etc/env.d
	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst() {
	# Set as default system VM if none exists
	java_pkg_postinst

	if use nsplugin || use browserplugin || use mozilla; then
		einfo "The java mozilla plugin supplied by this package does not"
		einfo "work with newer version mozilla/firefox."
		einfo "You need >=${PN}-1.4 for them."
	fi
	if ! use nsplugin && ( use browserplugin || use mozilla ); then
		echo
		ewarn "The 'browserplugin' and 'mozilla' useflags will not be honored in"
		ewarn "future jdk/jre ebuilds for plugin installation.  Please"
		ewarn "update your USE to include 'nsplugin'."
	fi
}

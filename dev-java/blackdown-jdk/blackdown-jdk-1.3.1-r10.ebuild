# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.3.1-r10.ebuild,v 1.25 2006/07/06 11:22:49 nelchael Exp $

inherit java toolchain-funcs

S=${WORKDIR}/j2sdk1.3.1
DESCRIPTION="Blackdown Java Development Kit 1.3.1"
HOMEPAGE="http://www.blackdown.org/"
SRC_URI="ppc? ( http://distro.ibiblio.org/pub/Linux/distributions/yellowdog/software/openoffice/j2sdk-1.3.1-02c-FCS-linux-ppc.bin )"

LICENSE="sun-bcla-java-vm"
SLOT="1.3"
KEYWORDS="ppc -*"
IUSE="doc browserplugin nsplugin mozilla"

DEPEND="doc? ( =dev-java/java-sdk-docs-1.3.1* )"

src_unpack () {
	if use ppc || use sparc; then
		# this is built on gcc 3.2 so only update if gcc 3.x is present
		if [ "`gcc-major-version`" != "3" ] ; then
			die "This is for gcc 3.x only"
		fi
		tail -n +400 ${DISTDIR}/${A} | tar jxpf -
	else
		unpack ${A}
	fi

	if use sparc; then
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

	# Install ns plugin
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

	dosym /opt/blackdown-jdk-1.3.1/include/linux/jni_md.h \
		/opt/blackdown-jdk-1.3.1/include/jni_md.h

	# install env into /etc/env.d
	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst() {
	java_pkg_postinst
	if ! use nsplugin && ( use browserplugin || use mozilla ); then
		echo
		ewarn "The 'browserplugin' and 'mozilla' useflags will not be honored in"
		ewarn "future jdk/jre ebuilds for plugin installation.  Please"
		ewarn "update your USE to include 'nsplugin'."
	fi
}


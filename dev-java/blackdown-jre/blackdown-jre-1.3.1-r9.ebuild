# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.3.1-r9.ebuild,v 1.3 2003/05/24 06:37:35 absinthe Exp $

IUSE=""

. /usr/portage/eclass/inherit.eclass
inherit java nsplugins

S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Blackdown Java Runtime Environment 1.3.1"
SRC_URI="ppc? http://distro.ibiblio.org/pub/Linux/distributions/yellowdog/software/openoffice/j2re-1.3.1-02c-FCS-linux-ppc.bin"

HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.5"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/java-scheme-2"
SLOT="0"
LICENSE="sun-bcla-java-vm"

# other arches will need to chase this down when its released for them
KEYWORDS="ppc"

src_unpack () {
	if (use ppc) || (use sparc) || (use sparc64) ; then 
                # this is built on gcc 3.2 so only update if gcc 3.x is present
                [ -z "${CC}" ] && CC=gcc
                if [ "`${CC} -dumpversion | cut -d. -f1,2`" = "2.95" ] ; then
                        die "This is for gcc 3.x only"
                fi

		tail +422 ${DISTDIR}/${A} | tar xjf -
	else
		unpack ${A}
	fi
	if (use sparc) || (use sparc64) ; then
		# The files are owned by 1000.100, for some reason.
		chown -R root.root
	fi
}

src_install () {
	dodir /opt/${P}

	cp -dpR ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
        find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	if [ "${ARCH}" == "x86" ] ; then
		PLATFORM="i386"
	elif [ "${ARCH}" == "ppc" ] ; then
		PLATFORM="ppc"
	elif [ "${ARCH}" == "sparc" ] || [ "${ARCH}" == "sparc64" ] ; then
		PLATFORM="sparc"
	fi
	inst_plugin /opt/${P}/plugin/${PLATFORM}/mozilla/javaplugin_oji.so

	mv ${D}/opt/${P}/lib/font.properties ${D}/opt/${P}/lib/font.properties.orig
	sed "s/standard symbols l/symbol/g" \
		< ${D}/opt/${P}/lib/font.properties.orig \
		> ${D}/opt/${P}/lib/font.properties
	rm ${D}/opt/${P}/lib/font.properties.orig

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	java_pkg_postinst
}


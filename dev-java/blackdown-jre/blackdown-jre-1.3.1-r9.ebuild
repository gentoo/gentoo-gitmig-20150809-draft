# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.3.1-r9.ebuild,v 1.17 2004/07/14 12:22:27 axxo Exp $

inherit java nsplugins gcc

S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Blackdown Java Runtime Environment 1.3.1"
HOMEPAGE="http://www.blackdown.org"
SRC_URI="ppc? ( http://distro.ibiblio.org/pub/Linux/distributions/yellowdog/software/openoffice/j2re-1.3.1-02c-FCS-linux-ppc.bin )"

LICENSE="sun-bcla-java-vm"
SLOT="0"
KEYWORDS="ppc"
IUSE=""

DEPEND="virtual/libc
	>=dev-java/java-config-0.2.5
	>=sys-apps/sed-4
	>=sys-devel/gcc-3.2"
PROVIDE="virtual/jre-1.3.1
	virtual/java-scheme-2"

src_unpack () {
	for a in ${A}; do
		if [[ ${a} == *.bin ]]; then
			echo ">>> Unpacking ${a}..."
			tail -n +422 ${DISTDIR}/${a} | tar xjf - || die
		else
			# Handle files (none right now) that don't have a gcc
			# version dependency
			unpack ${a}
		fi
	done

	# On sparc the files are owned by 1000:100 for some reason
	if use sparc; then
		# The files are owned by 1000.100, for some reason.
		chown -R root:root
	fi
}

src_install () {
	typeset platform

	dodir /opt/${P}

	cp -dpR ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	case ${ARCH} in
		amd64|x86) platform="i386" ;;
		ppc) platform="ppc" ;;
		sparc*) platform="sparc" ;;
	esac
	inst_plugin /opt/${P}/plugin/${platform}/mozilla/javaplugin_oji.so

	sed -i "s/standard symbols l/symbol/g" ${D}/opt/${P}/lib/font.properties

	set_java_env ${FILESDIR}/${VMHANDLE}
}

pkg_postinst () {
	# Only install the JRE as the system default if there's no JDK 
	# installed. Installing a JRE over an existing JDK will result
	# in major breakage, see #9289.
	if [ ! -f "${JAVAC}" ] ; then
		ewarn "Found no JDK, setting ${P} as default system VM"
		java_pkg_postinst
	fi
}

pkg_prerm() {
	if java-config -J | grep -q ${P} ; then
		ewarn "It appears you are removing your default system VM!"
		ewarn "Please run java-config -L then java-config -S to set a new system VM!"
	fi
}

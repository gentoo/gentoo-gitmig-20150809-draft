# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.4.1.ebuild,v 1.11 2004/06/07 02:40:27 agriffis Exp $

inherit java nsplugins gcc

S=${WORKDIR}/j2re1.4.1
DESCRIPTION="Blackdown Java Runtime Environment 1.4.1"

SRC_URI="
	x86? (
		http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc3.2.bin
		http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc2.95.bin
	)
	amd64? (
		http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc3.2.bin
	)
	sparc? (
		http://www.mirror.ac.uk/sites/ftp.blackdown.org/java-linux/JDK-1.4.1/sparc/01/j2re-1.4.1-01-linux-sparc-gcc3.2.bin
	)"

HOMEPAGE="http://www.blackdown.org"
DEPEND="virtual/glibc
	amd64? ( >=app-emulation/emul-linux-x86-baselibs-1 )
	>=dev-java/java-config-0.2.5
	>=sys-apps/sed-4"
RDEPEND="${DEPEND}
	sparc? ( >=sys-devel/gcc-3.2 )
	amd64? ( >=sys-devel/gcc-3.2 )"
PROVIDE="virtual/jre-1.4.1
	virtual/java-scheme-2"
SLOT="0"
LICENSE="sun-bcla-java-vm"
KEYWORDS="x86 sparc amd64"

src_unpack () {
	typeset a want_gcc_ver

	if [[ $(gcc-major-version) -eq 3 && $(gcc-minor-version) -ge 2 ]]; then
		want_gcc_ver=3.2
	else
		want_gcc_ver=2.95
	fi

	for a in ${A}; do
		if [[ ${a} == *gcc*.bin ]]; then
			if [[ ${a} == *-gcc${want_gcc_ver}.bin ]]; then
				echo ">>> Unpacking ${a}..."
				tail -n +461 ${DISTDIR}/${a} | tar xjf - || die
			fi
		else
			# Handle files (none right now) that don't have a gcc
			# version dependency
			unpack ${a}
		fi
	done
}

src_install () {
	typeset platform

	dodir /opt/${P}

	cp -a ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
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

	# Fix for bug #26629.
	if [ "${PROFILE_ARCH}" = "sparc64" ]
	then
		sed -i -e 's/\/\//\/sparc\//g' \
			${D}/etc/env.d/java/20blackdown-jre-1.4.1
	fi
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

pkg_postrm() {
	if java-config -J | grep -q ${P} ; then
		ewarn "It appears you are removing your default system VM!"
		ewarn "Please run java-config -L then java-config-S to set a new system VM!"
	fi
}

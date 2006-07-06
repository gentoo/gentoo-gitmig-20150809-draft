# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.4.1-r1.ebuild,v 1.18 2006/07/06 11:19:53 nelchael Exp $

inherit java toolchain-funcs

S=${WORKDIR}/j2re1.4.1
DESCRIPTION="Blackdown Java Runtime Environment 1.4.1"

SRC_URI="
	x86? (
		ftp://ftp.uk.linux.org/pub/linux/java//JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc3.2.bin
		ftp://ftp.uk.linux.org/pub/linux/java/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc2.95.bin
	)
	amd64? (
		ftp://ftp.uk.linux.org/pub/linux/java/JDK-1.4.1/i386/01/j2re-1.4.1-01-linux-i586-gcc3.2.bin
	)
	sparc? (
		ftp://ftp.uk.linux.org/pub/linux/java/JDK-1.4.1/sparc/01/j2re-1.4.1-01-linux-sparc-gcc3.2.bin
	)"
HOMEPAGE="http://www.blackdown.org"
DEPEND="
	emul-linux-x86? ( >=app-emulation/emul-linux-x86-baselibs-1 )
	>=sys-apps/sed-4"
RDEPEND="${DEPEND}
	sparc? ( >=sys-devel/gcc-3.2 )
	amd64? ( >=sys-devel/gcc-3.2 )"
SLOT="0"
LICENSE="sun-bcla-java-vm"
KEYWORDS="x86 sparc amd64 -*"
IUSE="emul-linux-x86 browserplugin nsplugin mozilla"

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

src_install() {
	typeset platform

	dodir /opt/${P}

	cp -a ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	# do not install plugins, security vulnerability   #72221
	rm -rf ${D}/opt/${P}/plugin/
	#if use nsplugin || use mozilla; then
	#	case ${ARCH} in
	#		amd64|x86) platform="i386" ;;
	#		ppc) platform="ppc" ;;
	#		sparc*) platform="sparc" ;;
	#	esac
	#	install_mozilla_plugin /opt/${P}/plugin/${platform}/mozilla/javaplugin_oji.so
	#fi

	sed -i "s/standard symbols l/symbol/g" ${D}/opt/${P}/lib/font.properties

	set_java_env ${FILESDIR}/${VMHANDLE}

	# Fix for bug #26629.
	if [[ "${PROFILE_ARCH}" == "sparc64" ]]; then
		sed -i -e 's/\/\//\/sparc\//g' \
			${D}/etc/env.d/java/20blackdown-jre-1.4.1
	fi
}

pkg_postinst() {
	java_pkg_postinst

	if use nsplugin || use browserplugin || use mozilla; then
		echo
		einfo "mozilla plugin NOT installed"
		einfo "http://www.blackdown.org/java-linux/java2-status/security/Blackdown-SA-2004-01.txt"
	fi

	if ! use nsplugin && ( use browserplugin || use mozilla ); then
		echo
		ewarn "The 'browserplugin' and 'mozilla' useflags will not be honored in"
		ewarn "future jdk/jre ebuilds for plugin installation.  Please"
		ewarn "update your USE to include 'nsplugin'."
	fi

	if use sparc; then
		echo
		ewarn "Blackdown has unresolved security bugs on SPARC and is going"
		ewarn "away soon because of it's binary-only nature."
		ewarn "See http://bugs.gentoo.org/show_bug.cgi?id=96229 and"
		ewarn "http://bugs.gentoo.org/show_bug.cgi?id=118114 for details."
		ebeep 5
		epause 10
	fi
}

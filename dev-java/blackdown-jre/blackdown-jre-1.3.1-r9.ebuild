# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.3.1-r9.ebuild,v 1.27 2006/07/06 11:19:53 nelchael Exp $

inherit java toolchain-funcs

S=${WORKDIR}/j2re1.3.1
DESCRIPTION="Blackdown Java Runtime Environment 1.3.1"
HOMEPAGE="http://www.blackdown.org"
SRC_URI="ppc? ( http://distro.ibiblio.org/pub/Linux/distributions/yellowdog/software/openoffice/j2re-1.3.1-02c-FCS-linux-ppc.bin )"

LICENSE="sun-bcla-java-vm"
SLOT="0"
KEYWORDS="ppc -*"
IUSE="browserplugin nsplugin mozilla"

DEPEND=">=sys-apps/sed-4
	>=sys-devel/gcc-3.2"

src_unpack() {
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

src_install() {
	typeset platform

	dodir /opt/${P}

	cp -dpR ${S}/{bin,lib,man,plugin} ${D}/opt/${P}/
	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	if use nsplugin ||       # global useflag for netscape-compat plugins
	   use browserplugin ||  # deprecated but honor for now
	   use mozilla; then     # wrong but used to honor it
		case ${ARCH} in
			amd64|x86) platform="i386" ;;
			ppc) platform="ppc" ;;
			sparc*) platform="sparc" ;;
		esac
		install_mozilla_plugin /opt/${P}/plugin/${platform}/mozilla/javaplugin_oji.so
	fi

	sed -i "s/standard symbols l/symbol/g" ${D}/opt/${P}/lib/font.properties

	set_java_env ${FILESDIR}/${VMHANDLE}

	if ! use nsplugin && ( use browserplugin || use mozilla ); then
		echo
		ewarn "The 'browserplugin' and 'mozilla' useflags will not be honored in"
		ewarn "future jdk/jre ebuilds for plugin installation.  Please"
		ewarn "update your USE to include 'nsplugin'."
	fi
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jdk/blackdown-jdk-1.4.1-r12.ebuild,v 1.4 2006/09/01 00:56:52 nichoj Exp $

JAVA_SUPPORTS_GENERATION_1="true"
inherit java-vm-2

JREV="01"

S="${WORKDIR}/j2sdk${PV}"
DESCRIPTION="Blackdown Java Development Kit ${PV}"
HOMEPAGE="http://www.blackdown.org"
J_URI="ftp://ftp.gwdg.de/pub/languages/java/linux/JDK-${PV}"
SRC_URI="x86? ( ${J_URI}/i386/${JREV}/j2sdk-${PV}-${JREV}-linux-i586-gcc3.2.bin )
		amd64? ( ${J_URI}/i386/${JREV}/j2sdk-${PV}-${JREV}-linux-i586-gcc3.2.bin )
		sparc? ( ${J_URI}/sparc/${JREV}/j2sdk-${PV}-${JREV}-linux-sparc-gcc3.2.bin )"

# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

LICENSE="sun-bcla-java-vm"
SLOT="1.4.1"
KEYWORDS="-* ~x86 ~sparc ~amd64"
IUSE="doc emul-linux-x86 nsplugin"

DEPEND=">=dev-java/java-config-0.2.6
	doc? ( =dev-java/java-sdk-docs-1.4.1* )
	emul-linux-x86? ( >=app-emulation/emul-linux-x86-baselibs-1.0 )"

JAVA_PROVIDE="jdbc-stdext"

# Extract the 'skip' value (offset of tarball) we should pass to tail
get_offset() {
	[ ! -f "$1" ] && return

	local offset="`gawk '
		/^[[:space:]]*skip[[:space:]]*=/ {

			sub(/^[[:space:]]*skip[[:space:]]*=/, "")
			SKIP = $0
		}

		END { print SKIP }
	' $1`"

	eval echo $offset
}

src_unpack() {
	local offset="`get_offset ${DISTDIR}/${A}`"

	if [ -z "${offset}" ] ; then
		eerror "Failed to get offset of tarball!"
		die "Failed to get offset of tarball!"
	fi

	echo ">>> Unpacking ${A}..."
	tail -n +${offset} ${DISTDIR}/${A} | tar --no-same-owner -jxpf -
}


src_install() {
	local PLATFORM=

	dodir /opt/${P}

	cp -a ${S}/{bin,jre,lib,man,include} ${D}/opt/${P}

	dodir /opt/${P}/share/java
	cp -a ${S}/{demo,src.zip} ${D}/opt/${P}/share

	dodoc README
	dohtml README.html

	# do not install plugins, security vulnerability   #72221
	rm -rf ${D}/opt/${P}/jre/plugin/

	#if use nsplugin; then
	#	if [ "${ARCH}" = "x86" ] ; then
	#		PLATFORM="i386"
	#	fi

	#	if [ "${ARCH}" = "amd64" ] ; then
	#		PLATFORM="i386"
	#	fi

	#	if [ "${ARCH}" = "sparc" ] ; then
	#		PLATFORM="sparc"
	#	fi

	#	install_mozilla_plugin /opt/${P}/jre/plugin/${PLATFORM}/mozilla/javaplugin_oji.so
	#fi

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dosed "s/standard symbols l/symbol/g" \
		/opt/${P}/jre/lib/font.properties

	# install env into /etc/env.d
	set_java_env

	# Fix for bug 26629
	if [[ "${PROFILE_ARCH}" == "sparc64" ]]; then
		dosym /opt/${P}/jre/lib/sparc /opt/${P}/jre/lib/sparc64
	fi
}

pkg_postinst() {
	# Set as default system VM if none exists
	java-vm-2_pkg_postinst

	if use nsplugin; then
		echo
		einfo "nsplugin plugin NOT installed"
		einfo "http://www.blackdown.org/java-linux/java2-status/security/Blackdown-SA-2004-01.txt"
	fi
	# if chpax is on the target system, set the appropriate PaX flags
	# this will not hurt the binary, it modifies only unused ELF bits
	# but may confuse things like AV scanners and automatic tripwire
	if has_version "sys-apps/chpax"
	then
		echo
		einfo "setting up conservative PaX flags for jar and javac"

		for paxkills in "jar" "javac" "java" "javah" "javadoc"
		do
			chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/bin/$paxkills
		done

		# /opt/blackdown-jdk-1.4.1/jre/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/jre/bin/java_vm

		einfo "you should have seen lots of chpax output above now"
		ewarn "make sure the grsec ACL contains those entries also"
		ewarn "because enabling it will override the chpax setting"
		ewarn "on the physical files - help for PaX and grsecurity"
		ewarn "can be given by #gentoo-hardened + hardened@gentoo.org"
	fi
}

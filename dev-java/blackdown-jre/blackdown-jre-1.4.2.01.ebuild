# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.4.2.01.ebuild,v 1.2 2004/11/26 12:48:02 lv Exp $

inherit java versionator

JREV="01"

JV="${PV}"
JV=$(get_version_component_range 1-3 ${JV})
DESCRIPTION="Blackdown Java Runtime Environment ${PV}"
J_URI="mirror://blackdown.org/JDK-${JV}"
SRC_URI="amd64? ( ${J_URI}/amd64/${JREV}/j2re-${JV}-${JREV}-linux-amd64.bin )
	x86? ( ${J_URI}/i386/${JREV}/j2re-${JV}-${JREV}-linux-i586.bin )"
#	sparc? ( ${J_URI}/sparc/${JREV}/j2re-${JV}-${JREV}-linux-sparc.bin )"
#	ppc? ( ${J_URI}/ppc/${JREV}j2re-${JV}-${JREV}-linux-ppc.bin )"

HOMEPAGE="http://www.blackdown.org"

SLOT="1.4.2"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* amd64 x86"
IUSE="mozilla"
DEPEND="virtual/libc
	>=dev-java/java-config-1.2.11
	>=sys-apps/sed-4
	>=sys-devel/gcc-3.2"

PROVIDE="virtual/jre-1.4.2
	virtual/java-scheme-2"

S="${WORKDIR}/j2re${JV}"
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

src_unpack () {
	local offset="`get_offset ${DISTDIR}/${A}`"

	if [ -z "${offset}" ] ; then
		eerror "Failed to get offset of tarball!"
		die "Failed to get offset of tarball!"
	fi

	echo ">>> Unpacking ${A}..."
	tail -n +${offset} ${DISTDIR}/${A} | tar --no-same-owner -jxp
}

unpack_jars() {
	# New to 1.4.2
	local PACKED_JARS="lib/tools.jar lib/rt.jar lib/jsse.jar lib/charsets.jar lib/ext/localedata.jar lib/plugin.jar javaws/javaws.jar"
	local JAVAHOME="${D}/opt/${P}"
	local UNPACK_CMD=""
	if [ -f "$JAVAHOME/lib/unpack" ]; then
		UNPACK_CMD="$JAVAHOME/lib/unpack"
		chmod +x "$UNPACK_CMD"
		#packerror=""
		for i in $PACKED_JARS; do
			if [ -f "$JAVAHOME/`dirname $i`/`basename $i .jar`.pack" ]; then
				einfo "Creating ${JAVAHOME}/${i}\n"
				"$UNPACK_CMD" "$JAVAHOME/`dirname $i`/`basename $i .jar`.pack" "$JAVAHOME/$i"
				if [ ! -f "$JAVAHOME/$i" ]; then
					die "Failed to unpack jar files ${i}." # Please refer\n"
					#ewarn "to the Troubleshooting section of the Installation\n"
					#ewarn "Instructions on the download page for more information.n"
					#packerror="1"
				fi
				rm -f "$JAVAHOME/`dirname $i`/`basename $i .jar`.pack"
			fi
		done
	fi
	rm -f "$UNPACK_CMD"
}

src_install () {
	typeset platform

	dodir /opt/${P}

	cp -a ${S}/{bin,lib,man,plugin} ${D}/opt/${P} || die "failed to copy"

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	if use mozilla; then
		case ${ARCH} in
			x86) platform="i386" ;;
			ppc) platform="ppc" ;;
			sparc*) platform="sparc" ;;
			amd64) platform="amd64" ;;
		esac
		install_mozilla_plugin /opt/${P}/plugin/${platform}/mozilla/libjavaplugin_oji.so
	fi

	sed -i "s/standard symbols l/symbol/g" ${D}/opt/${P}/lib/font.properties

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	# install env into /etc/env.d
	set_java_env ${FILESDIR}/${VMHANDLE} || die

	# Fix for bug 26629
	if [ "${PROFILE_ARCH}" = "sparc64" ]
	then
		dosym /opt/${P}/lib/sparc /opt/${P}/lib/sparc64
	fi

	unpack_jars
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.4.2_rc1.ebuild,v 1.9 2004/06/21 19:00:03 karltk Exp $

IUSE="doc"

inherit java nsplugins

JREV="rc1"

JV="${PV}"
JV="${JV/_rc1/}"

S="${WORKDIR}/j2re${JV}"
DESCRIPTION="Blackdown Java Runtime Environment ${PV}"
J_URI="ftp://ftp.tux.org/pub/java/JDK-${JV}"
SRC_URI="amd64? ( ${J_URI}/amd64/${JREV}/j2re-${JV}-${JREV}-linux-amd64.bin )
	x86? ( ${J_URI}/i386/${JREV}/j2re-${JV}-${JREV}-linux-i586-gcc3.2.bin )"
#	sparc? ( ${J_URI}/sparc/${JREV}/j2re-${JV}-${JREV}-linux-sparc.bin )"
#	ppc? ( ${J_URI}/ppc/${JREV}j2re-${JV}-${JREV}-linux-ppc.bin )"

HOMEPAGE="http://www.blackdown.org"

SLOT="1.4.2"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* amd64"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.6
	>=sys-apps/sed-4
	>=sys-devel/gcc-3.2"

PROVIDE="virtual/jre-1.4.2
	virtual/java-scheme-2"

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
	local PACKED_JARS="lib/tools.jar jre/lib/rt.jar jre/lib/jsse.jar jre/lib/charsets.jar jre/lib/ext/localedata.jar jre/lib/plugin.jar jre/javaws/javaws.jar"
	local JAVAHOME="${D}/opt/${P}"
	local UNPACK_CMD=""
	if [ -f "$JAVAHOME/lib/unpack" ]; then
		UNPACK_CMD="$JAVAHOME/lib/unpack"
		chmod +x "$UNPACK_CMD"
		packerror=""
		for i in $PACKED_JARS; do
			if [ -f "$JAVAHOME/`dirname $i`/`basename $i .jar`.pack" ]; then
				einfo "Creating ${JAVAHOME}/${i}\n"
				"$UNPACK_CMD" "$JAVAHOME/`dirname $i`/`basename $i .jar`.pack" "$JAVAHOME/$i"
				if [ ! -f "$JAVAHOME/$i" ]; then
					ewarn "Failed to unpack jar files ${i}. Please refer\n"
					ewarn "to the Troubleshooting section of the Installation\n"
					ewarn "Instructions on the download page for more information.n"
					packerror="1"
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

	cp -a ${S}/{bin,jre,lib,man} ${D}/opt/${P}

	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	case ${ARCH} in
		amd64|x86) platform="i386" ;;
		ppc) platform="ppc" ;;
		sparc*) platform="sparc" ;;
	esac
	inst_plugin /opt/${P}/jre/plugin/${platform}/mozilla/libjavaplugin_oji.so

	sed -i "s/standard symbols l/symbol/g" ${D}/opt/${P}/jre/lib/font.properties

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	# install env into /etc/env.d
	set_java_env ${FILESDIR}/${VMHANDLE} || die

	# Fix for bug 26629
	if [ "${PROFILE_ARCH}" = "sparc64" ]
	then
		dosym /opt/${P}/jre/lib/sparc /opt/${P}/jre/lib/sparc64
	fi

	unpack_jars
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
		ewarn "Please run java-config -L then java-config-S to set a new system VM!"
	fi
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.4.2_rc1.ebuild,v 1.1 2003/12/24 02:52:29 brad_mssw Exp $

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


if [ "${ARCH}" = "amd64" ]
then
	A="j2re-${JV}-${JREV}-linux-amd64.bin"
elif [ "${ARCH}" = "x86" ]
then
	A="j2re-${JV}-${JREV}-linux-i586-gcc3.2.bin"
elif [ "${ARCH}" = "sparc" ]
then
	A="j2re-${JV}-${JREV}-linux-sparc.bin"
elif [ "${ARCH}" = "ppc" ]
then
	A="j2re-${JV}-${JREV}-linux-ppc.bin"
fi

HOMEPAGE="http://www.blackdown.org"

SLOT="1.4.2"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* amd64"

DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.6
	doc? ( =dev-java/java-sdk-docs-1.4.1* )"

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

unpack_jars()
{
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
	local PLATFORM=

	dodir /opt/${P}

	cp -a ${S}/{bin,jre,lib,man} ${D}/opt/${P}


	dodoc COPYRIGHT LICENSE README INSTALL
	dohtml README.html

	# Install mozilla plugin
	if [ "${ARCH}" = "x86" ] ; then
		PLATFORM="i386"
	fi

	if [ "${ARCH}" = "amd64" ] ; then
		PLATFORM="amd64"
	fi

	if [ "${ARCH}" = "sparc" ] ; then
		PLATFORM="sparc"
	fi

	inst_plugin /opt/${P}/jre/plugin/${PLATFORM}/mozilla/javaplugin_oji.so

	find ${D}/opt/${P} -type f -name "*.so" -exec chmod +x \{\} \;

	dosed "s/standard symbols l/symbol/g" \
		/opt/${P}/jre/lib/font.properties

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
	# Set as default system VM if none exists
	java_pkg_postinst

}


# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/blackdown-jre/blackdown-jre-1.4.2.03-r12.ebuild,v 1.1 2006/08/25 17:48:28 nichoj Exp $

inherit java-vm-2 versionator

JREV=$(get_version_component_range 4- )
JV=$(get_version_component_range 1-3 )
J_URI="mirror://blackdown.org/JDK-${JV}"

DESCRIPTION="Blackdown Java Runtime Environment"
SRC_URI="amd64? ( ${J_URI}/amd64/${JREV}/j2re-${JV}-${JREV}-linux-amd64.bin )
	x86? ( ${J_URI}/i386/${JREV}/j2re-${JV}-${JREV}-linux-i586.bin )"
#	sparc? ( ${J_URI}/sparc/${JREV}/j2re-${JV}-${JREV}-linux-sparc.bin )"
#	ppc? ( ${J_URI}/ppc/${JREV}j2re-${JV}-${JREV}-linux-ppc.bin )"

HOMEPAGE="http://www.blackdown.org"

SLOT="1.4.2"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* ~amd64 ~x86"
IUSE="nsplugin"
DEPEND=">=sys-apps/sed-4"
JAVA_PROVIDE="jdbc-stdext"

S="${WORKDIR}/j2re${JV}"

JAVAHOME="${D}/opt/${P}"

# Don't install env files for generation-1, because generation-1 system vm
# always needs to be a JDK
JAVA_VM_NO_GENERATION1="true"

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
	tail -n +${offset} ${DISTDIR}/${A} | tar --no-same-owner -jxpf -
}

unpack_jars() {
	# New to 1.4.2
	local PACKED_JARS="lib/tools.jar lib/rt.jar lib/jsse.jar lib/charsets.jar lib/ext/localedata.jar lib/plugin.jar javaws/javaws.jar"
	local UNPACK_CMD=""
	if [ -f "$JAVAHOME/lib/unpack" ]; then
		UNPACK_CMD="$JAVAHOME/lib/unpack"
		chmod +x "$UNPACK_CMD"
		#packerror=""
		sed -i 's#/tmp/unpack.log#/dev/null\x00\x00\x00\x00\x00\x00#g' $UNPACK_CMD
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

src_install() {
	typeset platform

	dodir /opt/${P}

	cp -pPR ${S}/{bin,lib,man,plugin} ${JAVAHOME} || die "failed to copy"

	newicon ${JAVAHOME}/plugin/desktop/sun_java.png ${PN}-${SLOT}.png || die "failed to install icon"
	rm -fr ${JAVAHOME}/plugin/desktop
	make_desktop_entry "ControlPanel" "Java Control Panel" "${PN}-${SLOT}.png" "Settings" \
		|| die "failed to make desktop entry"

	dodoc COPYRIGHT README

	# Install mozilla plugin
	if use nsplugin; then
		case ${ARCH} in
			x86) platform="i386" ;;
			ppc) platform="ppc" ;;
			sparc*) platform="sparc" ;;
			amd64) platform="amd64" ;;
		esac
		install_mozilla_plugin /opt/${P}/plugin/${platform}/mozilla/libjavaplugin_oji.so
	fi

	sed -i "s/standard symbols l/symbol/g" ${D}/opt/${P}/lib/font.properties

	find ${JAVAHOME} -type f -name "*.so" -exec chmod +x \{\} \;

	# install env into /etc/env.d
	set_java_env

	# Fix for bug 26629
	if [[ "${PROFILE_ARCH}" = "sparc64" ]]; then
		dosym /opt/${P}/lib/sparc /opt/${P}/lib/sparc64
	fi

	unpack_jars
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/emul-linux-x86-java/emul-linux-x86-java-1.4.2.03-r2.ebuild,v 1.6 2007/08/17 10:18:50 betelgeuse Exp $

inherit multilib java-vm-2 versionator

JREV="03"

JV="${PV}"
JV=$(get_version_component_range 1-3 ${JV})
DESCRIPTION="32bit java emulation for amd64"
J_URI="mirror://blackdown.org/JDK-${JV}"
SRC_URI="${J_URI}/i386/${JREV}/j2re-${JV}-${JREV}-linux-i586.bin"

HOMEPAGE="http://www.blackdown.org"

SLOT="1.4.2"
LICENSE="sun-bcla-java-vm"
KEYWORDS="-* amd64"
IUSE="nsplugin"
DEPEND=">=sys-apps/sed-4"
RDEPEND="
	app-emulation/emul-linux-x86-xlibs
	app-emulation/emul-linux-x86-soundlibs"

S="${WORKDIR}/j2re${JV}"

JAVAHOME="${D}/opt/java32"

# 32bit binary package
pkg_setup() {
	ABI="x86"
	java-vm-2_pkg_setup
}

RESTRICT="strip"

# Extract the 'skip' value (offset of tarball) we should pass to tail
get_offset() {
	[[ ! -f "$1" ]] && return

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

	if [[ -z "${offset}" ]] ; then
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
	if [[ -f "$JAVAHOME/lib/unpack" ]]; then
		UNPACK_CMD="$JAVAHOME/lib/unpack"
		chmod +x "$UNPACK_CMD"
		#packerror=""
		sed -i 's#/tmp/unpack.log#/dev/null\x00\x00\x00\x00\x00\x00#g' $UNPACK_CMD
		for i in $PACKED_JARS; do
			if [[ -f "$JAVAHOME/${i%.jar}.pack" ]]; then
				einfo "Creating ${JAVAHOME}/${i}"
				"$UNPACK_CMD" "$JAVAHOME/${i%.jar}.pack" "$JAVAHOME/$i"
				if [[ ! -f "$JAVAHOME/$i" ]]; then
					die "Failed to unpack jar files ${i}." # Please refer\n"
					#ewarn "to the Troubleshooting section of the Installation\n"
					#ewarn "Instructions on the download page for more information.n"
					#packerror="1"
				fi
				rm -f "$JAVAHOME/${i%.jar}.pack"
			fi
		done
	fi
	rm -f "$UNPACK_CMD"
}

src_install() {
	typeset platform

	dodir /opt/java32

	cp -pPR ${S}/{bin,lib,man,plugin,javaws} ${JAVAHOME} || die "failed to copy"

	dodoc COPYRIGHT README
	dohtml README.html

	# Install mozilla plugin
	if use nsplugin ; then
		install_mozilla_plugin /opt/java32/plugin/i386/mozilla/libjavaplugin_oji.so
	fi

	sed -i "s/standard symbols l/symbol/g" ${D}/opt/java32/lib/font.properties

	find ${JAVAHOME} -type f -name "*.so" -exec chmod +x \{\} \;

	unpack_jars

	# Install java settings file for openoffice so that it will not try
	# to use the native 64bit jre and cause 2 minute startup...
	dodir /usr/$(get_libdir)/openoffice/share/config
	insinto /usr/$(get_libdir)/openoffice/share/config
	doins ${FILESDIR}/javasettings_Linux_x86.xml

	set_java_env
}

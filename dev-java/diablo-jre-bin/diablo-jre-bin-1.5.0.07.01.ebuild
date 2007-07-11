# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/diablo-jre-bin/diablo-jre-bin-1.5.0.07.01.ebuild,v 1.2 2007/07/11 19:58:37 mr_bones_ Exp $

inherit java-vm-2 eutils versionator

DESCRIPTION="Java Runtime Environment"
HOMEPAGE="http://www.FreeBSDFoundation.org/downloads/java.shtml"
MY_PV=$(replace_version_separator 3 '_')
MY_PVA=$(replace_version_separator 4 '-b' ${MY_PV})

SRC_URI="diablo-latte-freebsd6-i386-${MY_PVA}.tar.bz2"

LICENSE="sun-bcla-java-vm"
SLOT="1.5"
KEYWORDS="-* ~x86-fbsd"
RESTRICT="fetch"
IUSE="X nsplugin"

QA_TEXTRELS_x86="opt/${P}/jre/lib/i386/motif21/libmawt.so opt/${P}/jre/lib/i386/server/libjvm.so opt/${P}/jre/lib/i386/client/libjvm.so"

JAVA_VM_NO_GENERATION1=true

DEPEND=""
RDEPEND="X? ( || ( (
					x11-libs/libX11
					x11-libs/libXext
					x11-libs/libXi
					x11-libs/libXp
					x11-libs/libXt
					x11-libs/libXtst
				)
				virtual/x11
			)
		)
		=sys-freebsd/freebsd-lib-6*
		=virtual/libstdc++-3.3*"

S="${WORKDIR}/diablo-jre$(get_version_component_range 1-4 ${MY_PV})"

pkg_nofetch() {
	einfo "Please download ${SRC_URI} from:"
	einfo "${HOMEPAGE}"
	einfo "and move it to ${DISTDIR}"
}

src_install() {
	cd "${S}"
	local dirs="bin lib man plugin javaws"

	dodir /opt/${P}

	for i in $dirs ; do
		cp -pPR $i ${D}/opt/${P}/ || die "failed to build"
	done

	dodoc COPYRIGHT README
	dohtml Welcome.html

	if use nsplugin; then
		install_mozilla_plugin /opt/${P}/plugin/i386/ns7/libjavaplugin_oji.so
	fi

	# Change libz.so.3 to libz.so.1
	scanelf -qR -N libz.so.3 -F "#N" "${D}"/opt/${P}/ | \
		while read i; do
		if [[ $(strings "$i" | fgrep -c libz.so.3) -ne 1 ]]; then
			export SANITY_CHECK_LIBZ_FAILED=1
			break
		fi
		sed -i -e 's/libz\.so\.3/libz.so.1/g' "$i"
	done
	[[ "$SANITY_CHECK_LIBZ_FAILED" = "1" ]] && die "failed to change libz.so.3 to libz.so.1"

	# create dir for system preferences
	dodir /opt/${P}/.systemPrefs

	# install control panel for Gnome/KDE
	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}/" \
		-e "s/\(Name=Java\)/\1 Control Panel/" \
		${D}/opt/${P}/plugin/desktop/sun_java.desktop > \
		${T}/sun_java-jre.desktop

	domenu ${T}/sun_java-jre.desktop

	set_java_env
}

pkg_postinst() {
	# Create files used as storage for system preferences.
	PREFS_LOCATION=/opt/${P}/
	mkdir -p "${PREFS_LOCATION}"/.systemPrefs
	if [ ! -f "${PREFS_LOCATION}"/.systemPrefs/.system.lock ] ; then
		touch "${PREFS_LOCATION}"/.systemPrefs/.system.lock
		chmod 644 "${PREFS_LOCATION}"/.systemPrefs/.system.lock
	fi
	if [ ! -f "${PREFS_LOCATION}"/.systemPrefs/.systemRootModFile ] ; then
		touch "${PREFS_LOCATION}"/.systemPrefs/.systemRootModFile
		chmod 644 "${PREFS_LOCATION}"/.systemPrefs/.systemRootModFile
	fi

	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	if ! use X; then
		local xwarn="virtual/x11 and/or"
	fi

	echo
	ewarn "Some parts of Sun's JRE require ${xwarn} virtual/lpr to be installed."
	ewarn "Be careful which Java libraries you attempt to use."
}

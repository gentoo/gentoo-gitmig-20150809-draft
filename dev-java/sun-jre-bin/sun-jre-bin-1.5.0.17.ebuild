# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jre-bin/sun-jre-bin-1.5.0.17.ebuild,v 1.1 2008/12/06 13:39:46 betelgeuse Exp $

inherit pax-utils versionator eutils java-vm-2

UPDATE="$(get_version_component_range 4)"
UPDATE="${UPDATE#0}"
MY_PV="$(get_version_component_range 2-3)u${UPDATE}"

X86_AT="jdk-${MY_PV}-dlj-linux-i586.bin"
AMD64_AT="jdk-${MY_PV}-dlj-linux-amd64.bin"

DESCRIPTION="Sun's J2SE Runtime Environment, version ${SLOT}"
HOMEPAGE="http://java.sun.com/j2se/1.5.0/"
SRC_URI="x86? ( http://download.java.net/dlj/binaries/${X86_AT} )
		amd64? ( http://download.java.net/dlj/binaries/${AMD64_AT} )"
SLOT="1.5"
LICENSE="dlj-1.1"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="strip"
IUSE="X alsa nsplugin odbc"

RDEPEND="sys-libs/glibc
	alsa? ( media-libs/alsa-lib )
	X? (
		x11-libs/libXext
		x11-libs/libXi
		x11-libs/libXp
		x11-libs/libXtst
		x11-libs/libXt
		x11-libs/libX11
	)
	odbc? ( dev-db/unixODBC )"
DEPEND=""

JAVA_PROVIDE="jdbc-stdext jdbc-rowset"

QA_TEXTRELS_x86="opt/${P}/lib/i386/motif21/libmawt.so
	opt/${P}/lib/i386/libdeploy.so"

src_unpack() {
	mkdir bundled-jdk
	cd bundled-jdk
	sh "${DISTDIR}/${A}" --accept-license --unpack || die "Failed to unpack"

	cd ..
	bash "${FILESDIR}/construct.sh"  bundled-jdk sun-jdk-${PV} ${P} || die "construct.sh failed"
}

src_compile() {
	# Set PaX markings on all JDK/JRE executables to allow code-generation on
	# the heap by the JIT compiler. This has to be done before CDS - #215225
	pax-mark m $(list-paxables "${S}"/bin/*)

	# see bug #207282
	if use x86; then
		einfo "Creating the Class Data Sharing archives"
		"${S}"/bin/java -client -Xshare:dump || die
	fi
}

src_install() {
	local dirs="bin lib man"
	# only X86 has the plugin and javaws
	use x86 && dirs="${dirs} javaws plugin"
	dodir /opt/${P}

	cp -pPR ${dirs} "${D}/opt/${P}/" || die "failed to copy"

	dodoc CHANGES README THIRDPARTYLICENSEREADME.txt || die
	dohtml Welcome.html || die

	if use nsplugin; then
		local plugin_dir="ns7-gcc29"
		if has_version '>=sys-devel/gcc-3' ; then
			plugin_dir="ns7"
		fi

		if use x86 ; then
			install_mozilla_plugin /opt/${P}/plugin/i386/$plugin_dir/libjavaplugin_oji.so
		else
			eerror "No plugin available for amd64 arch"
		fi
	fi

	# FIXME figure out how to handle the control pannel conflict with
	# sun-jdk-bin

	# install control panel for Gnome/KDE
#	sed -e "s/INSTALL_DIR\/JRE_NAME_VERSION/\/opt\/${P}\/jre/" \
#		-e "s/\(Name=Java\)/\1 Control Panel ${SLOT}/" \
#		${D}/opt/${P}/plugin/desktop/sun_java.desktop > \
#		${T}/sun_java-${SLOT}.desktop

#	domenu ${T}/sun_java-${SLOT}.desktop

	# bug #56444
	insinto /opt/${P}/lib/
	newins "${FILESDIR}"/fontconfig.Gentoo.properties \
		fontconfig.properties || die

	set_java_env
	java-vm_revdep-mask
}

pkg_postinst() {
	# Set as default VM if none exists
	java-vm-2_pkg_postinst

	elog "The epoll-based implementation of SelectorProvider is not selected by"
	elog "default."
	elog "Use java -Djava.nio.channels.spi.SelectorProvider=sun.nio.ch.EPollSelectorProvider"
}

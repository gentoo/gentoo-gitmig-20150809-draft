# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/opera/opera-10.00_pre4126.ebuild,v 1.2 2009/02/04 16:45:28 jer Exp $

GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="A standards-compliant graphical Web browser"
HOMEPAGE="http://www.opera.com/"

SLOT="0"
LICENSE="OPERA-9.0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

RESTRICT="mirror strip test"

IUSE="elibc_FreeBSD gnome ia32 qt-static qt3 spell"
MY_LINGUAS="be bg cs da de el en en-GB es-ES es-LA et fi fr fr-CA fy hi hr hu id it ja ka ko lt mk nb nl nn pl pt pt-BR ru sv ta te tr uk zh-CN zh-TW"

for MY_LINGUA in ${MY_LINGUAS}; do
	IUSE="${IUSE} linguas_${MY_LINGUA/-/_}"
done

O_U="http://snapshot.opera.com/unix/snapshot-4126/"
O_P="${P/_pre/-}"

SRC_URI="
	x86-fbsd? ( ${O_U}intel-freebsd/${O_P}.freebsd6-shared-qt3.i386.tar.bz2 )
	ppc? ( ${O_U}ppc-linux/${O_P}.gcc4-shared-qt3.ppc.tar.bz2 )
	qt-static? (
		qt3? (
			amd64? (
				ia32? ( ${O_U}intel-linux/${O_P}.gcc4-static-qt3.i386.tar.bz2 )
				!ia32? ( ${O_U}x86_64-linux/${O_P}.gcc4-shared-qt3.x86_64.tar.bz2 )
			)
			x86? ( ${O_U}intel-linux/${O_P}.gcc4-static-qt3.i386.tar.bz2 )
		)
		!qt3? (
			amd64? (
				ia32? ( ${O_U}intel-linux/${O_P}.gcc4-static-qt3.i386.tar.bz2 )
				!ia32? ( ${O_U}x86_64-linux/${O_P}.gcc4-shared-qt3.x86_64.tar.bz2 )
			)
			x86? ( ${O_U}intel-linux/${O_P}.gcc4-static-qt3.i386.tar.bz2 )
		)
	)
	!qt-static? (
		qt3? (
			amd64? (
				ia32? ( ${O_U}intel-linux/${O_P}.gcc4-shared-qt3.i386.tar.bz2 )
				!ia32? ( ${O_U}x86_64-linux/${O_P}.gcc4-shared-qt3.x86_64.tar.bz2 )
			)
			x86? ( ${O_U}intel-linux/${O_P}.gcc4-shared-qt3.i386.tar.bz2 )
		)
		!qt3? (
			amd64? (
				ia32? ( ${O_U}intel-linux/${O_P}.gcc4-qt4.i386.tar.bz2 )
				!ia32? ( ${O_U}x86_64-linux/${O_P}.gcc4-shared-qt3.x86_64.tar.bz2 )
			)
			x86? ( ${O_U}intel-linux/${O_P}.gcc4-qt4.i386.tar.bz2 )
		)
	)
	"

DEPEND=">=sys-apps/sed-4"

RDEPEND="
	media-libs/jpeg
	media-libs/libexif
	>=media-libs/fontconfig-2.1.94-r1
	x11-libs/libXrandr
	x11-libs/libXp
	x11-libs/libXmu
	x11-libs/libXi
	x11-libs/libXft
	x11-libs/libXext
	x11-libs/libXcursor
	x11-libs/libX11
	x11-libs/libSM
	x11-libs/libICE
	!qt-static? ( media-libs/libpng )
	qt-static? ( !qt3? ( x11-libs/libXinerama media-libs/nas ) )
	x86? ( !qt-static? (
			qt3? ( =x11-libs/qt-3* )
			!qt3? ( =x11-libs/qt-core-4* =x11-libs/qt-gui-4* )
		   )
		 )
	amd64? (
		ia32? ( app-emulation/emul-linux-x86-qtlibs )
		!ia32? ( =x11-libs/qt-3* )
	)
	ppc? ( =x11-libs/qt-3* )
	spell? ( app-text/aspell )
	x86-fbsd? (
		=virtual/libstdc++-3*
		!qt-static? ( !qt3? ( =x11-libs/qt-3* ) )
	)
	"

opera_cd() {
	cd "${WORKDIR}"/${PN}* || die "failed to enter work directory"
	S="$(pwd)"
	einfo "Working in ${S}"
}

opera_linguas() {
	# Remove unwanted LINGUAS:
	local LINGUA
	local LNGDIR="${D}/opt/opera/share/opera/locale"
	einfo "Keeping these locales: ${LINGUAS}."
	for LINGUA in ${MY_LINGUAS}; do
		if ! use linguas_${LINGUA/-/_}; then
			LINGUA=$(find "${LNGDIR}" -maxdepth 1 -type d -iname ${LINGUA/_/-})
			rm -r "${LINGUA}"
		fi
	done
}

src_unpack() {
	unpack ${A}
	opera_cd

	epatch "${FILESDIR}/${PN}-gentoo.patch"
	epatch "${FILESDIR}/${PN}-simplify-desktop.patch"
	epatch "${FILESDIR}/${PN}-freedesktop.patch"

	# bug #181300:
	if use elibc_FreeBSD; then
		epatch "${FILESDIR}/${PN}-9.50-pluginpath-fbsd.patch"
	else
		epatch "${FILESDIR}/${PN}-9.50-pluginpath.patch"
	fi

	sed -i 	-e "s:config_dir=\"/etc\":config_dir=\"${D}/etc/\":g" \
		-e "s:\(str_localdirplugin=\).*$:\1/opt/opera/lib/opera/plugins:" \
		-e 's:#\(export LD_PRELOAD OPERA_FORCE_JAVA_ENABLED\):\1:' \
		-e 's:#\(OPERA_FORCE_JAVA_ENABLED=\):\1:' \
		install.sh || die "sed failed"

}

src_compile() {
	# This workaround is sadly needed because gnome2.eclass doesn't check
	# whether a configure script or Makefile exists.
	true
}

src_install() {
	opera_cd
	# Prepare installation directories for Opera's installer script.
	dodir /etc

	# Opera's native installer.
	./install.sh --prefix="${D}"/opt/opera || die "install.sh failed"

	einfo "It is safe to ignore warnings about failed checksums"
	einfo "and about files that would be ignored ..."
	einfo "Completing the installation where install.sh abandoned us ..."

	# java workaround
	sed -i -e 's:LD_PRELOAD="${OPERA_JAVA_DIR}/libawt.so":LD_PRELOAD="$LD_PRELOAD"\:"${OPERA_JAVA_DIR}/libawt.so":' "${D}"/opt/opera/bin/opera

	dosed /opt/opera/bin/opera
	dosed /opt/opera/share/opera/java/opera.policy

	# Adapt desktop file to Gnome when needed
	use gnome && sed -i -e s:"GenericName\[":"Comment\[": "${D}"/usr/share/applications/opera.desktop

	# Install a symlink /usr/bin/opera
	dodir /usr/bin
	dosym /opt/opera/bin/opera /usr/bin/opera

	# fix plugin path
	echo "Plugin Path=/opt/opera/lib/opera/plugins" >> "${D}"/etc/opera6rc

	# enable spellcheck
	if use spell; then
		if use qt-static; then
			DIR=${P}.1
		else
			use sparc && DIR=${P}.2 || DIR=${P}.5
		fi
		echo "Spell Check Engine=/opt/opera/lib/opera/${DIR}/spellcheck.so" >> "${D}"/opt/opera/share/opera/ini/spellcheck.ini
	fi

	dodir /etc/revdep-rebuild
	echo 'SEARCH_DIRS_MASK="/opt/opera/lib/opera/plugins"' > "${D}"/etc/revdep-rebuild/90opera

	# Change libz.so.3 to libz.so.1 for gentoo/freebsd
	if use elibc_FreeBSD; then
		scanelf -qR -N libz.so.3 -F "#N" "${D}"/opt/${PN}/ | \
		while read i; do
			if [[ $(strings "$i" | fgrep -c libz.so.3) -ne 1 ]];
			then
				export SANITY_CHECK_LIBZ_FAILED=1
				break
			fi
			sed -i -e 's/libz\.so\.3/libz.so.1/g' "$i"
		done
		[[ "$SANITY_CHECK_LIBZ_FAILED" = "1" ]] && die "failed to change libz.so.3 to libz.so.1"
	fi

	# Add the Opera man dir to MANPATH:
	insinto /etc/env.d
	echo 'MANPATH="/opt/opera/share/man"' >> "${D}"/etc/env.d/90opera

	[[ -z MY_LINGUAS ]] || opera_linguas
}

pkg_postinst() {
	use gnome && gnome2_pkg_postinst

	elog "To change the UI language, choose [Tools] -> [Preferences], open the"
	elog "[General] tab, click on [Details...] then [Choose...] and point the"
	elog "file chooser at /opt/opera/share/opera/locale/, then enter the"
	elog "directory for the language you want and [Open] the .lng file."
	elog
	elog "To use the spellchecker (USE=spell) for non-English simply do"
	elog "$ emerge app-dicts/aspell-[your language]."

	if use elibc_FreeBSD; then
		elog
		elog "To improve shared memory usage please set:"
		elog "$ sysctl kern.ipc.shm_allow_removed=1"
	fi

	elog "The current Opera builds may still have issues with plugins, notably"
	elog "net-www/netscape-flash. See also https://bugs.gentoo.org/198162"
}

pkg_postrm() {
	use gnome && gnome2_pkg_postrm
}

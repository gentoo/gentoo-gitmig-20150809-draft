# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/opera/opera-9.50_alpha1567.ebuild,v 1.1 2007/09/05 03:40:26 jer Exp $

GCONF_DEBUG="no"

inherit eutils gnome2

DESCRIPTION="Opera web browser"
HOMEPAGE="http://www.opera.com/"

SLOT="0"
LICENSE="OPERA-9.0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"

IUSE="qt-static spell gnome"
RESTRICT="strip mirror"

O_LNG=""
O_SUFF="1567"
O_VER="9.50-20070903"

# opera-9.50-20070903.1-static-qt.ppc-1567.tar.bz2 

O_URI="http://snapshot.opera.com/unix/9.50-Alpha-1/"
SRC_URI="
	x86? ( qt-static? (
	${O_URI}intel-linux/${PN}-${O_VER}.9-static-qt.i386${O_LNG}-${O_SUFF}.tar.bz2 ) )
	x86? ( !qt-static? ( ${O_URI}intel-linux/${PN}-${O_VER}.6-shared-qt.i386${O_LNG}-${O_SUFF}.tar.bz2 ) )
	amd64? ( !qt-static? ( ${O_URI}x86_64-linux/${PN}-${O_VER}.2-shared-qt.x86_64${O_LNG}-${O_SUFF}.tar.bz2 ) )
	ppc? ( ${O_URI}ppc-linux/${PN}-${O_VER}.1-static-qt.ppc${O_LNG}-${O_SUFF}.tar.bz2 )
	x86-fbsd? ( !qt-static? ( ${O_URI}intel-freebsd/${PN}-${O_VER}.4-shared-qt.i386.freebsd${O_LNG}-${O_SUFF}.tar.bz2 ) )
	x86-fbsd? ( qt-static? ( ${O_URI}/intel-freebsd/${PN}-${O_VER}.1-static-qt.i386.freebsd${O_LNG}-${O_SUFF}.tar.bz2 ) )"

#	amd64? ( qt-static? ( ${O_URI}x86_64-linux/${PN}-${O_VER}.2-static-qt.i386${O_LNG}-${O_SUFF}.tar.bz2 ) )
#	sparc? ( ${O_URI}sparc-linux/${PN}-${O_VER}.1-static-qt.sparc${O_LNG}-${O_SUFF}.tar.bz2 )

DEPEND=">=sys-apps/sed-4"

RDEPEND="x11-libs/libXrandr
	x11-libs/libXp
	x11-libs/libXmu
	x11-libs/libXi
	x11-libs/libXft
	x11-libs/libXext
	x11-libs/libXcursor
	x11-libs/libX11
	x11-libs/libSM
	x11-libs/libICE
	>=media-libs/fontconfig-2.1.94-r1
	!amd64? ( media-libs/libexif
			  spell? ( app-text/aspell )
			  x86? ( !qt-static? ( =x11-libs/qt-3* ) )
			  media-libs/jpeg )
	x86-fbsd? ( =virtual/libstdc++-3*
			    !qt-static? ( =x11-libs/qt-3* ) )"

S=${WORKDIR}/${A/.tar.bz2/}

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${PN}-9.00-install.patch"
	epatch "${FILESDIR}/${PN}-9.50-pluginpath.patch"

	sed -i -e "s:config_dir=\"/etc\":config_dir=\"${D}/etc/\":g" \
		-e "s:/usr/share/applnk:${D}/usr/share/applnk:g" \
		-e "s:/usr/share/pixmaps:${D}/usr/share/pixmaps:g" \
		-e "s:/usr/share/icons:${D}/usr/share/icons:g" \
		-e "s:/etc/X11:${D}/etc/X11:g" \
		-e "s:/usr/share/gnome:${D}/usr/share/gnome:g" \
		-e "s:/opt/gnome/share:${D}/opt/gnome/share:g" \
		-e 's:#\(OPERA_FORCE_JAVA_ENABLED=\):\1:' \
		-e 's:#\(export LD_PRELOAD OPERA_FORCE_JAVA_ENABLED\):\1:' \
		-e 's:read str_answer:return 0:' \
		-e "s:/opt/kde:${D}/usr/kde:" \
		-e "s:\(str_localdirplugin=\).*$:\1/opt/opera/lib/opera/plugins:" \
		install.sh || die "sed failed"
}

src_compile() {
	# This workaround is sadly needed because gnome2.eclass doesn't check
	# whether a configure script or Makefile exists.
	true
}

src_install() {
	local res
	# Prepare installation directories for Opera's installer script.
	dodir /etc

	# Opera's native installer.
	./install.sh --prefix="${D}"/opt/opera || die "install.sh failed"

	einfo "It is safe to ignore warnings about failed checksums"
	einfo "and about files that would be ignored ..."
	einfo "Completing the installation where install.sh abandoned us ..."

	# java workaround
	sed -i -e 's:LD_PRELOAD="${OPERA_JAVA_DIR}/libawt.so":LD_PRELOAD="$LD_PRELOAD"\:"${OPERA_JAVA_DIR}/libawt.so":' ${D}/opt/opera/bin/opera

	dosed /opt/opera/bin/opera
	dosed /opt/opera/share/opera/java/opera.policy

	# Install the icons
	insinto /usr/share/pixmaps
	doins usr/share/pixmaps/opera.xpm
	for res in 16x16 22x22 32x32 48x48 ; do
		insinto /usr/share/icons/hicolor/${res}/apps
		doins usr/share/icons/hicolor/${res}/apps/opera.png
	done

	# Install the menu entry
	insinto /usr/share/applications
	doins ${FILESDIR}/opera.desktop

	# Install a symlink /usr/bin/opera
	dodir /usr/bin
	dosym /opt/opera/bin/opera /usr/bin/opera

	# fix plugin path
	echo "Plugin Path=/opt/opera/lib/opera/plugins" >> ${D}/etc/opera6rc

	# enable spellcheck
	if use spell; then
		if use qt-static; then
			DIR=$O_VER.1
		else
			use sparc && DIR=$O_VER.2 || DIR=$O_VER.5
		fi
		echo "Spell Check Engine=/opt/opera/lib/opera/${DIR}/spellcheck.so" >> ${D}/opt/opera/share/opera/ini/spellcheck.ini
	fi

	dodir /etc/revdep-rebuild
	echo 'SEARCH_DIRS_MASK="/opt/opera/lib/opera/plugins"' > ${D}/etc/revdep-rebuild/90opera

	# Change libz.so.3 to libz.so.1 for gentoo/freebsd
	if use x86-fbsd; then
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

	# symlink to libflash-player.so:
	dosym /opt/netscape/plugins/libflashplayer.so \
		/opt/opera/lib/opera/plugins/libflashplayer.so

	# Add the Opera man dir to MANPATH:
	insinto /etc/env.d
	echo 'MANPATH="/opt/opera/share/man"' >> ${D}/etc/env.d/90opera
}

pkg_postinst() {
	use gnome && gnome2_pkg_postinst

	elog "For localized language files take a look at:"
	elog " http://www.opera.com/download/languagefiles/index.dml"
	elog
	elog "To use the spellchecker (USE=spell) for non-English simply do"
	elog "$ emerge app-dicts/aspell-[your language]."

	if use x86-fbsd; then
		elog
		elog "To improve shared memory usage please set:"
		elog "$ sysctl kern.ipc.shm_allow_removed=1"
	fi
}

pkg_postrm() {
	use gnome && gnome2_pkg_postrm
}

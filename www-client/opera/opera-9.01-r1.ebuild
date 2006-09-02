# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/opera/opera-9.01-r1.ebuild,v 1.1 2006/09/02 18:22:06 jer Exp $

GCONF_DEBUG="no"
inherit eutils gnome2

IUSE="qt-static spell gnome"
RESTRICT="nomirror"

OPERALNG="en"
OPERAVER="9.01-20060728"
OPERAFTPDIR="901/final/${OPERALNG}"
OPERASUFF="400"


DESCRIPTION="Opera web browser."
HOMEPAGE="http://www.opera.com"

OPERA_URI="ftp://ftp.opera.com/pub/opera/linux/${OPERAFTPDIR}/"
SRC_URI="
	x86? ( qt-static? ( ${OPERA_URI}i386/static/${PN}-${OPERAVER}.1-static-qt.i386-${OPERALNG}.tar.bz2 ) )
	x86? ( !qt-static? ( ${OPERA_URI}i386/shared/${PN}-${OPERAVER}.6-shared-qt.i386-${OPERALNG}.tar.bz2 ) )
	amd64? ( qt-static? ( ${OPERA_URI}i386/static/${PN}-${OPERAVER}.1-static-qt.i386-${OPERALNG}.tar.bz2 ) )
	amd64? ( !qt-static? ( ${OPERA_URI}i386/shared/${PN}-${OPERAVER}.6-shared-qt.i386-${OPERALNG}.tar.bz2 ) )
	sparc? ( ${OPERA_URI}sparc/static/${PN}-${OPERAVER}.1-static-qt.sparc-${OPERALNG}.tar.bz2 )
	ppc? ( ${OPERA_URI}ppc/static/${PN}-${OPERAVER}.1-static-qt.ppc-${OPERALNG}.tar.bz2 )"

S=${WORKDIR}/${A/.tar.bz2/}-${OPERASUFF}
DEPEND=">=sys-apps/sed-4
	amd64? ( sys-apps/setarch )"

RDEPEND="|| ( ( x11-libs/libXrandr
				x11-libs/libXp
				x11-libs/libXmu
				x11-libs/libXi
				x11-libs/libXft
				x11-libs/libXext
				x11-libs/libXcursor
				x11-libs/libX11
				x11-libs/libSM
				x11-libs/libICE
			  )
			  virtual/x11
			)
	>=media-libs/fontconfig-2.1.94-r1
	amd64? ( qt-static? ( app-emulation/emul-linux-x86-xlibs )
	         !qt-static? ( app-emulation/emul-linux-x86-qtlibs
							virtual/libstdc++ ) )
	!amd64? ( media-libs/libexif
	          spell? ( app-text/aspell )
	          x86? ( !qt-static? ( =x11-libs/qt-3*
									virtual/libstdc++ ) )
	          media-libs/jpeg )"

SLOT="0"
LICENSE="OPERA-9.0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch "${FILESDIR}/${PN}-9.00-install.patch"
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
	       install.sh || die
}

src_compile() {
	true
}

src_install() {
	# Prepare installation directories for Opera's installer script.
	dodir /etc

	# Opera's native installer.
	if [ ${ARCH} = "amd64" ]; then
		linux32 ./install.sh --prefix="${D}"/opt/opera || die
	else
		./install.sh --prefix="${D}"/opt/opera || die
	fi

	# java workaround
	sed -i -e 's:LD_PRELOAD="${OPERA_JAVA_DIR}/libawt.so":LD_PRELOAD="$LD_PRELOAD"\:"${OPERA_JAVA_DIR}/libawt.so":' ${D}/opt/opera/bin/opera

	dosed /opt/opera/bin/opera
	dosed /opt/opera/share/opera/java/opera.policy

	# Install the icons
	insinto /usr/share/pixmaps
	doins images/opera.xpm
	for res in 16x16 22x22 32x32 48x48 ; do
		insinto /usr/share/icons/hicolor/${res}/apps/
		newins images/opera_${res}.png opera.png
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
			DIR=$OPERAVER.1
		else
			use sparc && DIR=$OPERAVER.2 || DIR=$OPERAVER.5
		fi
		echo "Spell Check Engine=/opt/opera/lib/opera/${DIR}/spellcheck.so" >> ${D}/opt/opera/share/opera/ini/spellcheck.ini
	fi

	dodir /etc/revdep-rebuild
	echo 'SEARCH_DIRS_MASK="/opt/opera/lib/opera/plugins"' > ${D}/etc/revdep-rebuild/90opera
}

pkg_postinst() {
	use gnome && gnome2_pkg_postinst

	einfo "For localized language files take a look at:"
	einfo "http://www.opera.com/download/languagefiles/index.dml?platform=linux"
	einfo
	einfo "To change the spellcheck language edit /opt/opera/share/opera/ini/spellcheck.ini"
	einfo "and emerge app-text/aspell-language."
}


pkg_postrm() {
	use gnome && gnome2_pkg_postrm
}

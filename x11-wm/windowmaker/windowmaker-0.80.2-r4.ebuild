# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/windowmaker/windowmaker-0.80.2-r4.ebuild,v 1.16 2006/08/19 20:08:10 metalgod Exp $

inherit eutils flag-o-matic
filter-mfpmath "sse" "387"

IUSE="alsa esd gif gnome jpeg kde nls oss png xinerama"

MY_P=${P/windowm/WindowM}
S=${WORKDIR}/${MY_P}

DESCRIPTION="The fast and light GNUstep window manager"
SRC_URI="ftp://ftp.windowmaker.info/pub/source/release/${MY_P}.tar.gz
	 ftp://ftp.windowmaker.info/pub/source/release/WindowMaker-extra-0.1.tar.gz"
HOMEPAGE="http://www.windowmaker.info/"

DEPEND="|| ( ( x11-libs/libXt ) virtual/x11 )
	media-libs/hermes
	>=media-libs/tiff-3.5.5
	gif? ( >=media-libs/giflib-4.1.0-r3 )
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )"

RDEPEND="${DEPEND}
	nls? ( >=sys-devel/gettext-0.10.39 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~alpha ~mips amd64 ppc64"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PV}/${PN}-0.80.2-r1-gentoo.patch

	# scroll with the arrow keys
	cd ${S}/WINGs
	epatch ${FILESDIR}/${PV}/wlist.patch

	# transparency/translucency
	cd ${S}
	epatch ${FILESDIR}/${PV}/trance.patch.WM-0.80.2.diff

	# Add some BETTER xinerama support
	use xinerama && epatch ${FILESDIR}/${PV}/xinerama.patch.bz2

	# Fix GTK2 window flickering bug
	epatch ${FILESDIR}/${PV}/gtk2flickerfix.patch

	# Add options to WPrefs for single-click launching of windows
	# and maximize vs. shading when double-click on titlebars
	# http://orbita.starmedia.com/~neofpo/home.html
	epatch ${FILESDIR}/${PV}/wmfpo.patch
}

src_compile() {

	local myconf

	use gnome \
		&& myconf="${myconf} --enable-gnome" \
		|| myconf="${myconf} --disable-gnome"

	use kde \
		&& myconf="${myconf} --enable-kde" \
		&& export KDEDIR=/usr/kde/2 \
		|| myconf="${myconf} --disable-kde"

	if [ "$WITH_MODELOCK" ] ; then
		myconf="${myconf} --enable-modelock"
	else
		myconf="${myconf} --disable-modelock"
	fi

	use nls \
		&& export LINGUAS="`ls po/*.po | sed 's:po/\(.*\)\.po$:\1:'`" \
		|| myconf="${myconf} --disable-nls --disable-locale"

	use gif \
		|| myconf="${myconf} --disable-gif"

	use jpeg \
		|| myconf="${myconf} --disable-jpeg"

	use png \
		|| myconf="${myconf} --disable-png"


	use esd || use alsa || use oss \
		&& myconf="${myconf} --enable-sound" \
		|| myconf="${myconf} --disable-sound"

	econf \
		--sysconfdir=/etc/X11 \
		--with-x \
		--enable-newstyle \
		--enable-superfluous \
		--enable-usermenu \
		--with-appspath=/usr/lib/GNUstep/Apps \
		--with-pixmapdir=/usr/share/pixmaps \
		${myconf} || die

	cd ${S}/po
	cp Makefile Makefile.orig
	sed 's:zh_TW.*::' \
		Makefile.orig > Makefile

	cd ${S}/WPrefs.app/po
	cp Makefile Makefile.orig
	sed 's:zh_TW.*::' \
		Makefile.orig > Makefile

	cd ${S}
	for file in ${S}/WindowMaker/*menu*; do
		if [ -r $file ]; then
				sed -e 's/\/usr\/local\/GNUstep/\/usr\/lib\/GNUstep/g;
						s/\/usr\/local\/share\/WindowMaker/\/usr\/share\/WindowMaker/g;' < $file > $file.tmp;
				mv $file.tmp $file;
		fi;
	done;

	cd ${S}
	#0.80.1-r2 did not work with make -j4 (drobbins, 15 Jul 2002)
	#with future Portage, this should become "emake -j1"
	emake -j1 || die

	# WindowMaker Extra
	cd ../WindowMaker-extra-0.1
	econf || die

	emake -j1 || die
}

src_install() {

	einstall \
		sysconfdir=${D}/etc/X11 \
		wprefsdir=${D}/usr/lib/GNUstep/Apps/WPrefs.app \
		wpdatadir=${D}/usr/lib/GNUstep/Apps/WPrefs.app \
		wpexecbindir=${D}/usr/lib/GNUstep/Apps/WPrefs.app || die

	cp -f WindowMaker/plmenu ${D}/etc/X11/WindowMaker/WMRootMenu

	dodoc AUTHORS BUGFORM BUGS ChangeLog COPYING* INSTALL* FAQ* \
	      MIRRORS README* NEWS TODO

	# WindowMaker Extra
	cd ../WindowMaker-extra-0.1
	einstall || die

	newdoc README README.extra

	echo "#!/bin/bash" > wmaker
	echo "/usr/bin/wmaker" >> wmaker

	exeinto /etc/X11/Sessions/
	doexe wmaker
}

pkg_postinst() {
	einfo "/usr/share/GNUstep/ has moved to /usr/lib/GNUstep/"
	einfo "this means the WPrefs app has moved. If you have"
	einfo "entries for this in your menus, please correct them"
}

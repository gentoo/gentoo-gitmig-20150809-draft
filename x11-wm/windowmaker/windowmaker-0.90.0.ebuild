# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/windowmaker/windowmaker-0.90.0.ebuild,v 1.5 2004/10/29 19:55:42 fafhrd Exp $


inherit eutils gnustep

S=${WORKDIR}/${P/windowm/WindowM}

DESCRIPTION="The fast and light GNUstep window manager"
SRC_URI="ftp://ftp.windowmaker.org/pub/source/release/${P/windowm/WindowM}.tar.gz
	http://www.windowmaker.org/pub/source/release/WindowMaker-extra-0.1.tar.gz"
HOMEPAGE="http://www.windowmaker.org/"

IUSE="gif gnustep jpeg nls png tiff modelock vdesktop xinerama"
DEPEND="virtual/x11
	media-libs/fontconfig
	gif? ( || ( >=media-libs/libungif-4.1.0
			>=media-libs/giflib-4.1.0-r3))
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.6.1-r2 )"
RDEPEND="nls? ( >=sys-devel/gettext-0.10.39 )
	gnustep? ( gnustep-base/gnustep-env )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc"

src_compile() {
	local myconf

	# image format types
	# xpm is provided by X itself
	myconf="--enable-xpm $(use_enable png) $(use_enable jpeg) $(use_enable gif) $(use_enable tiff)"

	# non required X capabilities
	myconf="${myconf} $(use_enable modelock) $(use_enable vdesktop) $(use_enable xinerama)"

	# integrate with GNUstep environment, or not
	if use gnustep ; then
		egnustep_env
		myconf="${myconf} --with-appspath=${GNUSTEP_SYSTEM_ROOT}/Applications"
	else
		# no change from wm-0.80* ebuilds, as to not pollute things more
		myconf="${myconf} --with-appspath=/usr/lib/GNUstep/Applications"
	fi

	use nls \
		&& export LINGUAS="`ls po/*.po | sed 's:po/\(.*\)\.po$:\1:'`" \
		|| myconf="${myconf} --disable-nls --disable-locale"

	# default settings with $myconf appended
	econf \
		--sysconfdir=/etc/X11 \
		--with-x \
		--enable-usermenu \
		--with-pixmapdir=/usr/share/pixmaps \
		${myconf} || die

	# don't know if zh_TW is still non-functional, but leaving it out still
	#  for now
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
			if use gnustep ; then
				sed -e 's/\/usr\/local\/GNUstep/\/usr\/GNUstep\/System/g;
						s/\/usr\/local\/share\/WindowMaker/\/usr\/share\/WindowMaker/g;' < $file > $file.tmp;
			else
				sed -e 's/\/usr\/local\/GNUstep/\/usr\/lib\/GNUstep/g;
						s/\/usr\/local\/share\/WindowMaker/\/usr\/share\/WindowMaker/g;' < $file > $file.tmp;
			fi
			mv $file.tmp $file;
		fi;
	done;

	cd ${S}
	emake -j1 || die "windowmaker: make has failed"

	# WindowMaker Extra Package (themes and icons)
	cd ../WindowMaker-extra-0.1
	econf || die "windowmaker-extra: configure has failed"
	emake || die "windowmaker-extra: make has failed"
}

src_install() {
	emake install DESTDIR=${D} || die "windowmaker: install has failed."

	dodoc AUTHORS BUGFORM BUGS ChangeLog COPYING* INSTALL* FAQ* \
	      MIRRORS README* NEWS TODO

	# WindowMaker Extra
	cd ../WindowMaker-extra-0.1
	emake install DESTDIR=${D} || die "windowmaker-extra: install failed"

	newdoc README README.extra

	# create wmaker session shell script
	echo "#!/bin/bash" > wmaker
	echo "/usr/bin/wmaker" >> wmaker
	exeinto /etc/X11/Sessions/
	doexe wmaker
}

pkg_postinst() {
	einfo "If you are using 'startx' from the command line, and require"
	einfo "  .xinitrc, you may need to execute 'wmaker.inst', which will"
	einfo "  setup default configurations for you."

	if use gnustep ; then
		einfo "WPrefs.app is installed in you GNUstep System Applications directory."
	else
		einfo "Even though you are not using the GNUstep environment, wmaker.inst will"
		einfo "  create a 'GNUstep' directory in your home -- it uses this dirctory"
		einfo "  to store your WindowMaker configuration files."
		einfo "WPrefs.app can be launched at /usr/lib/GNUstep/Applications/WPrefs.app/WPrefs"
		einfo "  or by simply clicking on it in the WindowMaker default dock."
	fi

	if use vdesktop ; then
		ewarn "Note that enabling support for NETWM virtual desktops will make"
		ewarn "  menus that should be autoscrolling seem to not scroll, as they"
		ewarn "  are not off the screen, but rather in another virtual desktop."
	fi

	ebeep 4
	epause 4
}


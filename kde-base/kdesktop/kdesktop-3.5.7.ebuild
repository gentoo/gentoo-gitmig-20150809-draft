# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesktop/kdesktop-3.5.7.ebuild,v 1.8 2007/08/11 16:38:13 armin76 Exp $

KMNAME=kdebase
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-05.tar.bz2"

DESCRIPTION="KDesktop is the KDE interface that handles the icons, desktop popup menus and the screensaver system."
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xscreensaver"

DEPEND="$(deprange $PV $MAXKDEVER kde-base/libkonq)
	$(deprange $PV $MAXKDEVER kde-base/kcontrol)
	xscreensaver? ( x11-proto/scrnsaverproto )"
	# Requires the desktop background settings module,
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
RDEPEND="${DEPEND}
	$(deprange 3.5.6 $MAXKDEVER kde-base/kcheckpass)
	$(deprange 3.5.5 $MAXKDEVER kde-base/kdialog)
	$(deprange $PV $MAXKDEVER kde-base/konqueror)
	xscreensaver? ( x11-libs/libXScrnSaver )"

KMCOPYLIB="libkonq libkonq/"
KMEXTRACTONLY="kcheckpass/kcheckpass.h
	libkonq/
	kdm/kfrontend/themer/
	kioslave/thumbnail/configure.in.in" # for the HAVE_LIBART test
KMCOMPILEONLY="kcontrol/background
	kdmlib/"
KMNODOCS=true

src_unpack() {
	kde-meta_src_unpack
	# see bug #143375
	sed  -e "s:SUBDIRS = . lock pics patterns programs init:SUBDIRS = . lock pics patterns programs:" \
		-i kdesktop/Makefile.am
}
src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"
	kde-meta_src_compile
}

src_install() {
	# ugly, needs fixing: don't install kcontrol/background
	kde-meta_src_install

	rmdir "${D}/${PREFIX}/share/templates/.source/emptydir"
}

pkg_postinst() {
	kde_pkg_postinst
	mkdir -p "${PREFIX}/share/templates/.source/emptydir"
}

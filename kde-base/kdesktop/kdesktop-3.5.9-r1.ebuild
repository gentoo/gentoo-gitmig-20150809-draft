# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdesktop/kdesktop-3.5.9-r1.ebuild,v 1.4 2008/05/13 14:16:28 jer Exp $

KMNAME=kdebase
EAPI="1"
inherit kde-meta eutils

SRC_URI="${SRC_URI}
	mirror://gentoo/kdebase-3.5-patchset-05.tar.bz2
	mirror://gentoo/kde-3.5.9-seli-xinerama.tar.bz2"

DESCRIPTION="KDesktop is the KDE interface that handles the icons, desktop popup menus and screensaver system."
KEYWORDS="alpha ~amd64 hppa ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE="kdehiddenvisibility xscreensaver"

DEPEND=">=kde-base/libkonq-${PV}:${SLOT}
	>=kde-base/kcontrol-${PV}:${SLOT}
	xscreensaver? ( x11-proto/scrnsaverproto )"
	# Requires the desktop background settings module,
	# so until we separate the kcontrol modules into separate ebuilds :-),
	# there's a dep here
RDEPEND="${DEPEND}
	>=kde-base/kcheckpass-${PV}:${SLOT}
	>=kde-base/kdialog-${PV}:${SLOT}
	>=kde-base/konqueror-${PV}:${SLOT}
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

	# Xinerama patch by Lubos Lunak.
	# http://ktown.kde.org/~seli/xinerama/
	epatch "${WORKDIR}/kdebase-kdesktop-only-seli-xinerama.patch"
}
src_compile() {
	myconf="${myconf} $(use_with xscreensaver)"
	kde-meta_src_compile
}

pkg_postinst() {
	kde_pkg_postinst

	dodir "${PREFIX}"/share/templates/.source/emptydir
}

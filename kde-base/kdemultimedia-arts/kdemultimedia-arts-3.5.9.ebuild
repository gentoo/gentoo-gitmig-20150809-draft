# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdemultimedia-arts/kdemultimedia-arts-3.5.9.ebuild,v 1.7 2008/05/18 14:41:13 maekke Exp $

ARTS_REQUIRED="yes"
KMNAME=kdemultimedia
KMMODULE=arts
EAPI="1"
inherit kde-meta eutils

DESCRIPTION="aRts pipeline builder and other tools"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa"
KMEXTRACTONLY="mpeglib_artsplug/configure.in.in" # needed because the artsc-config call is here
KMEXTRA="doc/artsbuilder"

RDEPEND="alsa? ( media-libs/alsa-lib )"

pkg_setup() {
	kde_pkg_setup

	if use alsa && ! built_with_use --missing true media-libs/alsa-lib midi; then
		eerror "The alsa USE flag in this package enables ALSA support"
		eerror "for libkmid, KDE midi library."
		eerror "For this reason, you have to merge media-libs/alsa-lib"
		eerror "with the midi USE flag enabled, or disable alsa USE flag"
		eerror "for this package."
		die "Missing midi USE flag on media-libs/alsa-lib"
	fi
}

src_compile() {
	local myconf="$(use_with alsa)"
	kde-meta_src_compile
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kmix/kmix-3.4.0.ebuild,v 1.3 2005/03/18 16:22:04 morfic Exp $

KMNAME=kdemultimedia
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta eutils

DESCRIPTION="aRts mixer gui"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="alsa"
DEPEND="alsa? ( media-libs/alsa-lib )"
KMEXTRACTONLY="kscd/configure.in.in"

src_compile() {
	# alsa 0.9 not supported
	use alsa && myconf="$myconf --with-alsa --with-arts-alsa" || myconf="$myconf --without-alsa --disable-alsa"

	kde-meta_src_compile
}
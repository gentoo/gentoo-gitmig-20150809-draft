# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-kde/xmms-kde-3.1_beta1.ebuild,v 1.9 2004/09/15 19:26:29 eradicator Exp $

inherit kde eutils

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="xmms-kde is a MP3 player integrated into the KDE panel. It can also be used to control XMMS and Noatun from the panel."
HOMEPAGE="http://xmms-kde.sourceforge.net/"
SRC_URI="mirror://sourceforge/xmms-kde/${MY_P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc sparc"
IUSE="xmms sdl xinerama"

DEPEND="xmms? ( >=media-sound/xmms-1.2.7-r23 )
	sdl? ( >=media-libs/smpeg-0.4.4-r4 )
	sys-devel/autoconf"
need-kde 3.1

# I don't think we need to slot this...
# SLOT="${KDEMAJORVER}.${KDEMINORVER}"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${P}-libsuffix-fix.patch
	aclocal
	autoconf
}

src_compile() {
	myconf="--enable-final --disable-libsuffix --disable-gtk-test `use_enable xinerama`"

	kde_src_compile
}

src_install() {
	kde_src_install

	dodoc MISSING VERSION
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/k3guitune/k3guitune-0.4.ebuild,v 1.2 2004/08/09 01:50:15 pkdawson Exp $

inherit eutils

DESCRIPTION="K3Guitune is a program for KDE 3 that lets you tune musical instruments."
HOMEPAGE="http://home.planet.nl/~lamer024/k3guitune.html"
SRC_URI="http://home.planet.nl/~lamer024/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="alsa arts oss"

DEPEND=">=kde-base/kdelibs-3
	alsa? ( media-libs/alsa-lib )"

src_compile() {
	local myconf
	myconf="$(use_enable alsa) $(use_enable arts) $(use_enable oss)"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

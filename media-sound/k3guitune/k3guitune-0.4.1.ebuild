# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/k3guitune/k3guitune-0.4.1.ebuild,v 1.4 2004/09/14 16:36:52 eradicator Exp $

DESCRIPTION="A program for KDE 3 that lets you tune musical instruments."
HOMEPAGE="http://home.planet.nl/~lamer024/k3guitune.html"
SRC_URI="http://home.planet.nl/~lamer024/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc amd64"
IUSE="alsa arts oss debug xinerama"

DEPEND=">=kde-base/kdelibs-3
	alsa? ( media-libs/alsa-lib )"

src_compile() {
	local myconf
	myconf="$(use_enable alsa) $(use_enable arts) $(use_enable oss) $(use_enable debug) $(use_with xinerama)"
	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS COPYING ChangeLog INSTALL README TODO
}

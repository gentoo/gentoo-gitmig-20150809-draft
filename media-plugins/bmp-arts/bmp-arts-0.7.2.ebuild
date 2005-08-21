# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/bmp-arts/bmp-arts-0.7.2.ebuild,v 1.1 2005/08/21 17:00:09 chainsaw Exp $

inherit eutils
IUSE=""
SLOT="0"

DESCRIPTION="Beep Media Player (BMP) Arts output plug-in"
SRC_URI="http://www.intelligenzartificiale.it/public/blog/res/bmp-arts-plugin-${PV}.tar.gz"
HOMEPAGE="http://www.sosdg.org/~larne/w/Plugin_list"

LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="media-sound/beep-media-player
	kde-base/arts"

S="${WORKDIR}/bmp-arts-plugin-${PV}"

src_compile() {
	cd ${S}
	mkdir =build && cd =build
	ECONF_SOURCE=".."
	econf || die "configure failed!"
	emake || die "make failed!"
}

src_install () {
	dodoc AUTHORS ChangeLog ChangeLog.0 NEWS README

	cd "${S}/=build"
	make DESTDIR=${D} libdir=`beep-config --output-plugin-dir` install || die
}

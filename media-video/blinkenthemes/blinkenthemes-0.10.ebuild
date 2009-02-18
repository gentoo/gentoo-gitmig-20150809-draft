# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/blinkenthemes/blinkenthemes-0.10.ebuild,v 1.6 2009/02/18 18:53:40 beandog Exp $

DESCRIPTION="Themes for blinkensim"
HOMEPAGE="http://www.blinkenlights.net/project/developer-tools"
SRC_URI="http://www.blinkenlights.de/dist/blinkenthemes-0.10.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 x86"
IUSE=""

DEPEND="media-libs/blib
	dev-util/pkgconfig"
RDEPEND=""

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" \
		install || die "install failed"
}

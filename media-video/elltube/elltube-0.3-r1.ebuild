# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/elltube/elltube-0.3-r1.ebuild,v 1.1 2009/06/01 21:36:04 hwoarang Exp $

EAPI="2"

inherit eutils

DESCRIPTION="A YouTube Downloader and Converter"
HOMEPAGE="http://sourceforge.net/projects/elltube"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.4
	<dev-python/PyQt4-4.5[X]
	media-video/ffmpeg"

src_compile() {
	#just pass since make command does nasty stuff :)
	true
}

src_install() {
	emake DESTDIR="${D}" PREFIX="/usr" install || die "emake install failed"
	dodoc CHANGELOG || die "dodoc failed"
}

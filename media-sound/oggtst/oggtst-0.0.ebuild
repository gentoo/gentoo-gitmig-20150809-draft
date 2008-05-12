# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/oggtst/oggtst-0.0.ebuild,v 1.17 2008/05/12 09:19:56 aballier Exp $

DESCRIPTION="A tool for calculating ogg-vorbis playing time"
HOMEPAGE="http://gnometoaster.rulez.org/"
SRC_URI="http://gnometoaster.rulez.org/archive/${PN}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=media-libs/libao-0.8.0
	>=media-libs/libvorbis-1.0_rc2"
DEPEND="${RDEPEND}
	=sys-devel/automake-1.4*"

S=${WORKDIR}/${PN}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/kstreamripper/kstreamripper-0.3.4.ebuild,v 1.4 2008/05/13 06:41:44 drac Exp $

inherit kde

DESCRIPTION="KStreamripper - a nice KDE3 frontend to media-sound/streamripper"
HOMEPAGE="http://kstreamripper.tuxipuxi.org/"
# Portage isn't capable to get along with this url.
# SRC_URI="http://www.tuxipuxi.org/?download=${P}.tar.bz2"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=media-sound/streamripper-1.32-r2"
DEPEND="${RDEPEND}
	>=dev-util/scons-0.96.1"
need-kde 3.2

src_compile() {
	local myconf="kdeincludes=$(kde-config --prefix)/include prefix=/usr"
	use amd64 && myconf="${myconf} libsuffix=64"
	unset CFLAGS # freaking scons is passing CFLAGS into g++
	scons configure ${myconf} || die "configure failed"
	scons || die "scons failed"
}

src_install() {
	DESTDIR="${D}" scons install
	dodoc AUTHORS ChangeLog NEWS README TODO
}

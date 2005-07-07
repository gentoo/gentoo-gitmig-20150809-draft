# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/adplug/adplug-1.5.1.ebuild,v 1.2 2005/07/07 18:50:20 spock Exp $

IUSE=""

DESCRIPTION="A free, cross-platform, hardware independent AdLib sound player library"
HOMEPAGE="http://adplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"

DEPEND=">=dev-cpp/libbinio-1.2"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}

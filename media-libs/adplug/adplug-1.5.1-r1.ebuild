# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/adplug/adplug-1.5.1-r1.ebuild,v 1.1 2006/01/07 17:47:33 spock Exp $

IUSE=""

DESCRIPTION="A free, cross-platform, hardware independent AdLib sound player library"
HOMEPAGE="http://adplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND=">=dev-cpp/libbinio-1.2"

src_compile() {
	# A simple hack to make adplay work with libbinio 1.4+
	CXXFLAGS="${CXXFLAGS} -I/usr/include/libbinio"
	econf || die "econf"
	emake || die "emake"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS BUGS ChangeLog NEWS README TODO
}

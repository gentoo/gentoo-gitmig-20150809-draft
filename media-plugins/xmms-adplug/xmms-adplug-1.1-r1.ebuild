# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-adplug/xmms-adplug-1.1-r1.ebuild,v 1.2 2006/05/29 19:19:11 blubb Exp $

IUSE=""

MY_PN="adplug-xmms"
MY_P="${MY_PN}-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A plug-in that adds support for the AdLib music files to XMMS"
HOMEPAGE="http://adplug.sourceforge.net/"
SRC_URI="mirror://sourceforge/adplug/${MY_P}.tar.bz2"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86"

DEPEND=">=media-libs/adplug-1.4.1
	media-sound/xmms"

src_compile() {
	# A simple hack to make adplay work with libbinio 1.4+
	CXXFLAGS="${CXXFLAGS} -I/usr/include/libbinio"
	econf || die "econf"
	emake || die "emake"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS README TODO
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/xmms-oggre/xmms-oggre-0.3.ebuild,v 1.1 2005/01/25 22:28:08 chriswhite Exp $

MY_P=${P/xmms-/}
DESCRIPTION="Outputs the sound into OGG files"
HOMEPAGE="http://sourceforge.net/projects/my-xmms-plugs/"
SRC_URI="mirror://sourceforge/my-xmms-plugs/${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
# This package does not fair with big-endian on my
# ppc, so marking against it until I get stuff
# resolved upstream.  Chris
KEYWORDS="~x86 -ppc"
IUSE=""

RDEPEND="${DEPEND}
	>=media-sound/xmms-1.2.4"

DEPEND="media-libs/libvorbis
	 media-libs/libogg
	 >=dev-libs/glib-1.2.2
	 >=x11-libs/gtk+-1.2.2"

S="${WORKDIR}/${MY_P}"

DOCS="ChangeLog INSTALL README NEWS AUTHORS"

src_install() {
	make install DESTDIR=${D} || die "make install failed"
	dodoc ${DOCS}
}

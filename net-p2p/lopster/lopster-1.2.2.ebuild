# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.2.2.ebuild,v 1.1 2004/08/30 17:09:08 squinky86 Exp $

IUSE="nls oggvorbis zlib flac"

DESCRIPTION="A Napster Client using GTK"
HOMEPAGE="http://lopster.sourceforge.net"
SRC_URI="mirror://sourceforge/lopster/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )
	zlib? ( sys-libs/zlib )
	flac? ( media-libs/flac )
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

src_compile() {
	econf \
		--with-pthread \
		--with-zlib \
		`use_enable nls` \
		`use_with zlib` \
		`use_with flac` \
		`use_with oggvorbis ogg` || die "econf failed"

	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS README ChangeLog NEWS TODO
}

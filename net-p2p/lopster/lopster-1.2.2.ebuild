# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.2.2.ebuild,v 1.8 2005/09/16 04:28:14 agriffis Exp $

IUSE="nls vorbis zlib flac"

DESCRIPTION="A Napster Client using GTK"
HOMEPAGE="http://lopster.sourceforge.net"
SRC_URI="mirror://sourceforge/lopster/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha amd64 ~hppa ppc ~sparc x86"

DEPEND="=x11-libs/gtk+-1.2*"
RDEPEND="nls? ( sys-devel/gettext )
	zlib? ( sys-libs/zlib )
	flac? ( media-libs/flac )
	vorbis? ( >=media-libs/libvorbis-1.0 )"

src_compile() {
	econf \
		--with-pthread \
		`use_enable nls` \
		`use_with zlib` \
		`use_with flac` \
		`use_with vorbis ogg` || die "econf failed"

	emake || die
}

src_install () {
	einstall || die
	dodoc AUTHORS BUGS README ChangeLog NEWS TODO
}

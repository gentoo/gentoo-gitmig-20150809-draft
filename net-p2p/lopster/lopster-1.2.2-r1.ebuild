# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/lopster/lopster-1.2.2-r1.ebuild,v 1.4 2005/09/12 18:07:46 mkay Exp $

inherit eutils

IUSE="nls vorbis zlib flac"

DESCRIPTION="A Napster Client using GTK"
HOMEPAGE="http://lopster.sourceforge.net"
SRC_URI="mirror://sourceforge/lopster/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

RDEPEND="=x11-libs/gtk+-1.2*
	nls? ( sys-devel/gettext )
	zlib? ( sys-libs/zlib )
	flac? ( media-libs/flac )
	vorbis? ( >=media-libs/libvorbis-1.0 )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.59
	>=sys-devel/automake-1.9"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-bugfixes-1.patch
	cd ${S}
	export WANT_AUTOCONF=2.5
	./autogen.sh
}

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

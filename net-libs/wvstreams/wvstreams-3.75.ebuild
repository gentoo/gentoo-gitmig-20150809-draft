# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/wvstreams/wvstreams-3.75.ebuild,v 1.3 2004/04/04 09:48:33 dholm Exp $

inherit eutils

DESCRIPTION="A network programming library in C++"
HOMEPAGE="http://open.nit.ca/wiki/?page=WvStreams"
SRC_URI="http://people.nit.ca/~jim/${P}.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc -alpha ~amd64 -hppa ~ppc"
IUSE="gtk qt oggvorbis speex fam berkdb gdbm pam"

RDEPEND="gtk? ( >=x11-libs/gtk+-2.2.0 )
	qt? ( >=x11-libs/qt-3.0.5 )
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0
		speex? ( <=media-libs/speex-1.0 ) )
	!oggvorbis? ( speex? ( >=media-libs/speex-1.0 ) )
	fam? ( >=app-admin/fam-2.7.0 )
	>=sys-libs/db-3
	gdbm? ( >=sys-libs/gdbm-1.8.0 )
	pam? ( >=sys-libs/pam-0.75 )
	>=sys-libs/zlib-1.1.4
	dev-libs/openssl"

DEPEND="${RDEPEND}
	virtual/glibc"

S=${WORKDIR}/${P}.0

src_unpack() {
	unpack ${A} ; cd ${S}

	epatch ${FILESDIR}/${P}-makefile.patch
	epatch ${FILESDIR}/${P}-fPIC.patch
}

src_compile() {
	econf `use_with gtk` \
		`use_with qt` \
		`use_with oggvorbis ogg` \
		`use_with oggvorbis vorbis` \
		`use_with fam` \
		`use_with gdbm` \
		`use_with pam` \
		`use_with qt` \
		--enable-verbose \
		--with-bdb \
		--with-openssl \
		--with-zlib \
		|| die
	make || die "compile failed"
}

src_install() {
	make DESTDIR=${D} install || die
}

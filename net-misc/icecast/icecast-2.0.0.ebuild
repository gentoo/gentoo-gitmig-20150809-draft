# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icecast/icecast-2.0.0.ebuild,v 1.5 2004/03/29 01:17:08 vapier Exp $

inherit eutils

DESCRIPTION="An opensource alternative to shoutcast that supports mp3 and ogg streaming"
HOMEPAGE="http://www.icecast.org/"
SRC_URI="http://www.icecast.org/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha ~amd64"
IUSE="oggvorbis curl"

DEPEND="virtual/glibc
	dev-libs/libxml2
	dev-libs/libxslt
	oggvorbis? ( >=media-libs/libvorbis-1.0
		>=media-libs/libogg-1.0 )
	curl? ( net-misc/curl )"

src_compile() {
	local myconf=""
	use oggvorbis || myconf="${myconf} --without-ogg --without-vorbis"
	use curl || myconf="${myconf} --disable-yp"
	econf \
		--sysconfdir=/etc/icecast2 \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS README TODO HACKING NEWS
	rm -rf ${D}usr/share/doc/icecast
}

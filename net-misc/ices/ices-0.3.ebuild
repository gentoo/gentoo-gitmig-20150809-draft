# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ices/ices-0.3.ebuild,v 1.5 2004/01/21 06:32:07 raker Exp $

IUSE="oggvorbis perl python"

DESCRIPTION="icecast MP3 streaming client. supports on the fly re-encoding"
SRC_URI="http://www.icecast.org/files/ices/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="media-sound/lame
	dev-libs/libxml2
	>=media-libs/libshout-2.0
	oggvorbis? ( >=media-libs/libogg-1.0
		>=media-libs/libvorbis-1.0 )"

src_compile ()
{
	local myconf="--with-gnu-ld"

	use python && myconf="${myconf} --with-python"

	use perl && myconf=${myconf}" --with-perl"

	use oggvorbis && myconf="${myconf} --with-vorbis"

	econf \
		--sysconfdir=/etc/ices \
		--with-lame \
		--with-docdir=/usr/share/doc/ices-0.3/html \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install ()
{
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS BUGS NEWS README INSTALL README.playlist TODO
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ices/ices-0.4.ebuild,v 1.2 2004/08/31 07:39:32 pyrania Exp $

IUSE="oggvorbis perl python faad flac"

DESCRIPTION="icecast MP3 streaming client. supports on the fly re-encoding"
SRC_URI="http://svn.xiph.org/releases/ices/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="media-sound/lame
	dev-libs/libxml2
	>=media-libs/libshout-2.0
	faad? >=media-libs/faad2-2.0
	flac? >=media-libs/flac-1.1.0
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
		--with-docdir=/usr/share/doc/${P}/html \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install ()
{
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS BUGS NEWS README INSTALL README.playlist TODO
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/net-misc/ices/ices-0.2.3.ebuild,v 1.1 2002/07/25 20:41:39 raker Exp $

S=${WORKDIR}/${P}
DESCRIPTION="icecast MP3 streaming client. supports on the fly re-encoding"
SRC_URI="http://www.icecast.org/releases/${P}.tar.gz"
HOMEPAGE="http://www.icecast.org"
LICENSE="GPL"
KEYWORDS="x86 -ppc -sparc -sparc64"
SLOT="0"

DEPEND="net-misc/icecast
	media-sound/lame
	oggvorbis? ( >=media-libs/libvorbis-1.0 )"

src_unpack () 
{
	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/docdir.diff
}

src_compile ()
{
	local myconf
	#use python && myconf="--with-python-includes=/usr/include/python2.2/"
	use perl && myconf=${myconf}" --with-perl"

	if [ "`use oggvorbis`" ]; then
		myconf="${myconf} --with-vorbis=/usr/lib
	fi

	./configure --prefix=/usr \
		--sysconfdir=/etc/ices \
		--mandir=/usr/share/man \
		--localstatedir=/var \
		--host=${CHOST} \
		--with-lame \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install ()
{
	
	make DESTDIR=${D} install || die "make install failed"

}


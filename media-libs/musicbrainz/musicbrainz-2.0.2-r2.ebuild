# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/musicbrainz/musicbrainz-2.0.2-r2.ebuild,v 1.10 2004/06/18 06:49:58 eradicator Exp $

inherit libtool distutils eutils

DESCRIPTION="Client library to access metadata of mp3/vorbis/CD media"
HOMEPAGE="http://www.musicbrainz.org/"
SRC_URI="ftp://ftp.musicbrainz.org/pub/musicbrainz/lib${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa ~alpha ~amd64"
IUSE="python"

RDEPEND="virtual/glibc
	dev-libs/expat"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7
	dev-util/pkgconfig"

S=${WORKDIR}/lib${P}

src_unpack() {
	unpack ${A}

	cd ${S}
	if use python ; then
		epatch ${FILESDIR}/${P}.patch
	fi

	# Needed... see bug #54009
	WANT_AUTOMAKE=1.7 aclocal
	WANT_AUTOMAKE=1.7 automake -c
	WANT_AUTOCONF=2.5 autoconf
}

src_compile() {
	econf --enable-cpp-headers || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS ChangeLog INSTALL README TODO docs/mb_howto.txt

	if use python ; then
		cd ${S}/python
		distutils_src_install

		dodir /usr/share/doc/${PF}/python/examples/
		cp -r examples ${D}/usr/share/doc/${PF}/python
	fi
}

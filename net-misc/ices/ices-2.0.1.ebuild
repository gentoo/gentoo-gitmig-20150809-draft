# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ices/ices-2.0.1.ebuild,v 1.2 2005/02/06 16:56:40 luckyduck Exp $

IUSE=""

DESCRIPTION="icecast OGG streaming client. supports on the fly re-encoding"
SRC_URI="http://downloads.xiph.org/releases/ices/${P}.tar.bz2"
HOMEPAGE="http://www.icecast.org/ices.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc64"

DEPEND="dev-libs/libxml2
	dev-util/pkgconfig
	>=media-libs/libshout-2.0
	>=media-libs/libvorbis-1.0"

src_compile ()
{
	econf --sysconfdir=/etc/ices2 || die "configure failed"

	emake || die "make failed"
}

src_install ()
{
	make DESTDIR=${D} install || die "make install failed"

	dodoc AUTHORS README TODO

	# Add the stock configs...
	dodir /etc/ices2
	mv ${D}usr/share/ices/ices-live.xml \
		${D}etc/ices2/ices-live.xml.dist
	mv ${D}usr/share/ices/ices-playlist.xml \
		${D}etc/ices2/ices-playlist.xml.dist

	# Move the html to it's proper location...
	dodir /usr/share/doc/${P}/html
	mv ${D}usr/share/ices/*.html ${D}usr/share/doc/${P}/html
	mv ${D}usr/share/ices/style.css ${D}usr/share/doc/${P}/html

	# Nothing is left here after things are moved...
	rmdir ${D}usr/share/ices
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ices/ices-2.0_beta4.ebuild,v 1.2 2004/04/07 07:46:09 eradicator Exp $

IUSE=""

DESCRIPTION="icecast MP3 streaming client. supports on the fly re-encoding"
SRC_URI="http://www.icecast.org/files/${PN}-2.0-Beta4.tar.gz"
HOMEPAGE="http://www.icecast.org/ices.php"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"

DEPEND="dev-libs/libxml2
	dev-util/pkgconfig
	>=media-libs/libshout-2.0
	>=media-libs/libvorbis-1.0"

S=${WORKDIR}/${PN}-2.0-Beta4

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
	dodir /usr/share/doc/${PN}-2.0_beta4/html
	mv ${D}usr/share/ices/*.html ${D}usr/share/doc/${PN}-2.0_beta4/html
	mv ${D}usr/share/ices/style.css ${D}usr/share/doc/${PN}-2.0_beta4/html

	# Nothing is left here after things are moved...
	rmdir ${D}usr/share/ices
}

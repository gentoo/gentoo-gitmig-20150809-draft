# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icecast/icecast-2.3.1.ebuild,v 1.2 2007/04/18 10:59:49 dragonheart Exp $

IUSE="yp theora"

inherit eutils

DESCRIPTION="An opensource alternative to shoutcast that supports mp3, ogg (vorbis/theora) and aac streaming"
HOMEPAGE="http://www.icecast.org/"
SRC_URI="http://downloads.xiph.org/releases/icecast/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="dev-libs/libxslt
	media-libs/libogg
	media-libs/libvorbis
	theora? ( media-libs/libtheora )
	yp? ( <net-misc/curl-7.16.0 )"

src_compile() {
	econf \
		--sysconfdir=/etc/icecast2 \
		$(use_enable yp) \
		${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO HACKING NEWS conf/icecast.xml.dist
	dohtml -A chm,hhc,hhp doc/*
	doman ${S}/debian/icecast2.1

	newinitd ${FILESDIR}/init.d.icecast icecast

	fperms 600 /etc/icecast2/icecast.xml

	rm -rf ${D}/usr/share/doc/icecast
}

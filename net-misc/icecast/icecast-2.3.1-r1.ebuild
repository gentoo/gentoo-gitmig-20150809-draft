# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icecast/icecast-2.3.1-r1.ebuild,v 1.2 2006/04/30 23:12:34 weeve Exp $

inherit eutils

DESCRIPTION="An opensource alternative to shoutcast that supports mp3, ogg (vorbis/theora) and aac streaming"
HOMEPAGE="http://www.icecast.org/"
SRC_URI="http://downloads.xiph.org/releases/icecast/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="theora yp"

DEPEND="dev-libs/libxslt
	media-libs/libogg
	media-libs/libvorbis
	theora? ( media-libs/libtheora )
	yp? ( >=net-misc/curl-7.10.0 )"

src_compile() {
	econf \
		--sysconfdir=/etc/icecast2 \
		$(use_enable yp) || die "configure failed"

	emake || die "make failed"
}

pkg_preinst() {
	enewuser icecast -1 "-1" -1 nogroup || die "Problem adding icecast user"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS README TODO HACKING NEWS conf/icecast.xml.dist
	dohtml -A chm,hhc,hhp doc/*
	doman ${S}/debian/icecast2.1

	newinitd ${FILESDIR}/init.d.icecast icecast

	insinto /etc/icecast2/
	doins ${FILESDIR}/icecast.xml
	fperms 600 /etc/icecast2/icecast.xml

	keepdir /var/log/icecast
	chown icecast ${D}/var/log/icecast

	rm -rf ${D}/usr/share/doc/icecast
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/icecast2/icecast2-08072002.ebuild,v 1.6 2003/02/13 14:54:01 vapier Exp $

DESCRIPTION="streaming media server capable of delivering ogg-vorbis streams"
SRC_URI="http://ibiblio.org/sbw/gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.icecast.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc"

DEPEND=">=media-libs/libvorbis-1.0
	>=dev-libs/libxml-1.8.0"


src_compile() {	
	econf || die
	emake || die
}

src_install() {	
	dodoc README AUTHORS HACKING COPYING TODO
	newbin src/icecast icecast2
	insinto /etc
	doins ${FILESDIR}/icecast2.xml
}

pkg_postinst() {
	einfo "Please edit the configuration file located at /etc/icecast2.xml"
	einfo "to configure your icecast2 server. Execute with icecast2 -c /etc/icecast2.xml"
	einfo "to start your streaming server."
}

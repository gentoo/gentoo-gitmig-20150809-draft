# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Packaged by Blake Watters <sbw@ibiblio.org>

S=${WORKDIR}/${P}
DESCRIPTION="A streaming media server capable of delivering ogg-vorbis streams."
SRC_URI="http://ibiblio.org/sbw/gentoo/icecast2-08072002.tar.bz2"
HOMEPAGE="http://www.icecast.org"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc sparc64"

DEPEND=">=media-libs/libvorbis-1.0
		>=dev-libs/libxml-1.8.0"


src_compile() {	

	econf || die

	emake || die
}

src_install() {	
	dodoc README AUTHORS HACKING COPYING TODO
	
	exeinto /usr/bin
	newexe src/icecast icecast2

	insinto /etc
	doins ${FILESDIR}/icecast2.xml
}

pkg_postinst() {
	einfo "Please edit the configuration file located at /etc/icecast2.xml"
    einfo "to configure your icecast2 server. Execute with icecast2 -c /etc/icecast2.xml"
    einfo "to start your streaming server."
    einfo
}

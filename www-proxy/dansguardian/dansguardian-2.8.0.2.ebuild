# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/dansguardian/dansguardian-2.8.0.2.ebuild,v 1.1 2004/08/27 20:16:36 rl03 Exp $

inherit eutils

DESCRIPTION="Web content filtering via proxy"
HOMEPAGE="http://dansguardian.org"
SRC_URI="http://mirror.dansguardian.org/downloads/2/Stable/${P}.source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""
DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/dansguardian-xnaughty-2.7.6-1.diff
}

src_compile() {
	./configure \
		--prefix= \
		--installprefix=${D} \
		--mandir=/usr/share/man/ \
		--cgidir=/var/www/localhost/cgi-bin/ || die "./configure failed"
	emake || die "emake failed"
}

src_install() {
	if [ -d "/etc/logrotate.d" ]; then mkdir -p ${D}/etc/logrotate.d; fi
	make install || die "make install failed"

	dodir /etc/init.d
	cp ${FILESDIR}/dansguardian.init ${D}/etc/init.d/dansguardian

	rm -rf ${D}/etc/rc.d

	einfo "Fixing location of initscript"
	sed 's/rc.d\///' ${D}/etc/dansguardian/logrotation > ${D}/etc/dansguardian/logrotation.fixed
	mv -f ${D}/etc/dansguardian/logrotation.fixed ${D}/etc/dansguardian/logrotation

	dodoc INSTALL README LICENSE
}

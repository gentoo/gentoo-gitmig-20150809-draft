# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-proxy/dansguardian/dansguardian-2.7.1.ebuild,v 1.3 2005/02/06 18:33:02 corsair Exp $

MY_P="DansGuardian-${PV}"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="Web content filtering via proxy"
HOMEPAGE="http://dansguardian.org"
SRC_URI="http://mirror.dansguardian.org/downloads/2/Alpha/${MY_P}-0.source.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="www-proxy/squid"

src_compile() {
	./configure \
		--prefix= \
		--installprefix=${D} \
		--mandir=/usr/share/man/ || die "./configure failed"
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

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/freepops/freepops-0.0.17.ebuild,v 1.1 2004/09/22 14:11:25 squinky86 Exp $

DESCRIPTION="WebMail->POP3 converter and more"
HOMEPAGE="http://freepops.sourceforge.net/"
SRC_URI="mirror://sourceforge/freepops/${P}.tar.gz
	http://dev.gentoo.org/~squinky86/files/${PV}-yahoo.lua"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=" doc? ( >=app-doc/doxygen-1.3* )
	>=net-misc/curl-7.10.8 "

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	cp ${DISTDIR}/${PV}-yahoo.lua ${S}/src/lua/yahoo.lua || die
}

src_compile() {
	./configure.sh linux || die "configure failed"
	emake -j1 all WHERE=/usr/ || die "make failed"
	if use doc ; then
		make doc || die "make doc failed"
	fi
}

src_install() {
	make install DESTDIR=${D} WHERE=/usr/ || die
	dodoc AUTHORS README ChangeLog TODO \
		${D}/usr/share/doc/${PN}/MANUAL.txt
	rm -rf ${D}/usr/share/doc/${PN}

	exeinto /etc/init.d ; newexe buildfactory/freePOPsd.initd freepopsd
	insinto /etc/conf.d ; newins buildfactory/freePOPsd.confd freepopsd
}

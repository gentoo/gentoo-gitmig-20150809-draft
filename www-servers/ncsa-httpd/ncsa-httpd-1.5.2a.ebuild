# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/ncsa-httpd/ncsa-httpd-1.5.2a.ebuild,v 1.2 2004/09/05 09:43:04 swegener Exp $

inherit eutils

# httpd_1.5.2a-export
MY_P=httpd_${PV}-export
S=${WORKDIR}/${MY_P}
DESCRIPTION="NCSA HTTPd, a classic web server"
HOMEPAGE="http://hoohoo.ncsa.uiuc.edu"
KEYWORDS="~x86"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/Web/httpd/Unix/ncsa_httpd/current/${MY_P}_source.tar.Z"
DEPEND=""
LICENSE="ncsa-1.3"
SLOT="1"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}.patch
}

src_compile() {
	chown -R root:root *
	make linux || die
	cd support/auth
	gcc -o uudecode uudecode.c
	gcc -o uuencode uuencode.c
}

src_install() {
	INSDIR=/usr/local/etc/httpd/
	exeinto $INSDIR
	doexe httpd

	keepdir $INSDIR/htdocs
	keepdir $INSDIR/logs

	cp -rf cgi-bin ${D}/usr/local/etc/httpd/

	cd conf
	cp access.conf-dist access.conf
	cp httpd.conf-dist httpd.conf
	cp srm.conf-dist srm.conf
	cd ..

	cp -rf conf ${D}/usr/local/etc/httpd/
	cp -rf icons ${D}/usr/local/etc/httpd/

	cd src
	cp httpd.man httpd.1
	cd ..

	exeinto $INSDIR/support
	doexe support/dbm2std
	doexe support/dbmdigest
	doexe support/dbmgroup
	doexe support/dbmpasswd
	doexe support/htdigest
	doexe support/htpasswd
	doexe support/inc2shtml
	doexe support/std2dbm
	doexe support/unescape
	doexe support/webgrab

	exeinto $INSDIR/support/auth
	doexe support/auth/pgp-dec
	doexe support/auth/pgp-enc
	doexe support/auth/ripem-dec
	doexe support/auth/ripem-enc
	doexe support/auth/uudecode
	doexe support/auth/uuencode

	doman src/httpd.1
	mv support/README README-SUPPORT
	dodoc COPYRIGHT BUGS CHANGES CREDITS README README-SUPPORT \
		support/README.change-passwd
}

pkg_postinst() {
	ewarn "In the spirit of nostalgia, all files are in the classic"
	ewarn "directory of /usr/local/etc/httpd.  The main binary is"
	ewarn "/usr/local/etc/httpd/httpd.  Documentation and man pages"
	ewarn "are in the normal places"
	echo ""
	ewarn "It's not a good idea to run this in a production environment."
}

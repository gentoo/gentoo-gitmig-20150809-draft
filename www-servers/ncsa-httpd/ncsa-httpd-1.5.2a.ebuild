# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/ncsa-httpd/ncsa-httpd-1.5.2a.ebuild,v 1.4 2005/08/24 11:26:20 ka0ttic Exp $

inherit eutils toolchain-funcs

MY_P="httpd_${PV}-export"
S="${WORKDIR}/${MY_P}"
DESCRIPTION="NCSA HTTPd, a classic web server"
HOMEPAGE="http://hoohoo.ncsa.uiuc.edu"
SRC_URI="ftp://ftp.ncsa.uiuc.edu/Web/httpd/Unix/ncsa_httpd/current/${MY_P}_source.tar.Z"

LICENSE="ncsa-1.3"
SLOT="1"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sys-libs/gdbm-1.8.3"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}.patch
	epatch ${FILESDIR}/${P}-gdbm_compat.patch
}

src_compile() {
	chown -R root:0 *
	make CFLAGS="${CFLAGS}" linux || die "make linux failed"
	cd support/auth
	$(tc-getCC) -Wall ${CFLAGS} uuencode.c -o uuencode || \
		die "failed to build uuencode"
}

src_install() {
	local INSDIR=/usr/local/etc/httpd
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

	cd support
	exeinto $INSDIR/support
	doexe dbm{2std,digest,group,passwd} ht{digest,passwd} inc2shtml std2dbm \
		unescape webgrab

	cd auth
	exeinto $INSDIR/support/auth
	doexe pgp-{dec,enc} ripem-{dec,enc} uu{de,en}code

	cd ${S}
	newman src/httpd.man src/httpd.1
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

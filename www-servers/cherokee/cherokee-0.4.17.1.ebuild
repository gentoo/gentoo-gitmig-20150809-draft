# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.4.17.1.ebuild,v 1.3 2005/04/17 13:12:30 ka0ttic Exp $

MY_PV=0.4.17

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="ftp://alobbs.com/cherokee/0.4/${MY_PV}/${P}.tar.gz"
HOMEPAGE="http://www.alobbs.com/cherokee"
LICENSE="GPL-2"

RDEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4-r1"

DEPEND=">=sys-devel/automake-1.7.5
	${RDEPEND}"

KEYWORDS="x86 ppc"
SLOT="0"
IUSE=""

S="${WORKDIR}/${PN}-${MY_PV}"

src_unpack() {
	unpack ${A}
	cd ${S}

	# bug 86038 - cherokee will fail to build with >=gnutls-1.2.0 (API change)
	if has_version '>=net-libs/gnutls-1.2.0' ; then
		sed -i 's/\(gnutls_certificate_set_rsa\)\(_params\)/\1_export\2/' \
			src/virtual_server.c || die "sed failed"
	fi
}

src_compile() {
	./configure \
		--prefix=/usr --sysconfdir=/etc \
		--disable-static $my_conf --with-pic || die "configure failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog COPYING INSTALL README

	# install the Gentoo-ised config file

	cp ${FILESDIR}/${PN}-${MY_PV}-cherokee.conf ${D}/etc/cherokee/cherokee.conf

	# remove the installed sample config file
#	rm ${D}/etc/cherokee/cherokee.conf.sample

	# add default doc-root and cgi-bin locations
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin

	# add init.d script
	dodir /etc/init.d
	cp ${FILESDIR}/${PN}-${MY_PV}-init.d ${D}/etc/init.d/cherokee
}

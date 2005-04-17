# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.4.19.ebuild,v 1.2 2005/04/17 17:05:33 weeve Exp $

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="http://www.0x50.org/download/${PV%.*}/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.0x50.org/"
LICENSE="GPL-2"

RDEPEND="virtual/libc
	>=sys-libs/zlib-1.1.4-r1"

DEPEND=">=sys-devel/automake-1.7.5
	${RDEPEND}"

KEYWORDS="~x86 ~ppc ~sparc"
SLOT="0"
IUSE=""

src_unpack() {
	unpack ${A}
	cd ${S}

	# bug 86038 - cherokee will fail to build with >=gnutls-1.2.0 (API change)
	if has_version '>=net-libs/gnutls-1.2.0' ; then
		sed -i 's/\(gnutls_certificate_set_rsa\)\(_params\)/\1_export\2/' \
			cherokee/virtual_server.c || die "sed failed"
	fi
}

src_compile() {
	./configure \
		--prefix=/usr \
		--sysconfdir=/etc \
		--disable-static \
		--with-pic || die "configure failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc AUTHORS ChangeLog COPYING INSTALL README

	insinto /etc/cherokee
	newins ${FILESDIR}/${PN}-0.4.17-cherokee.conf cherokee.conf || \
		die "newins failed"

	# add default doc-root and cgi-bin locations
	dodir /var/www/localhost/htdocs
	dodir /var/www/localhost/cgi-bin

	newinitd ${FILESDIR}/${PN}-0.4.17-init.d ${PN} || die "newinitd failed"
}

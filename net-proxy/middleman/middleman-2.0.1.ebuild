# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/middleman/middleman-2.0.1.ebuild,v 1.3 2005/07/15 00:02:47 swegener Exp $

DESCRIPTION="Advanced HTTP/1.1 proxy server with features designed to increase privacy and remove unwanted content"
SRC_URI="mirror://sourceforge/middle-man/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/middle-man"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="pam zlib"

DEPEND="virtual/libc
	dev-libs/libpcre
	pam? ( sys-libs/pam )
	zlib? (	sys-libs/zlib )"

src_compile() {
	econf \
		--sysconfdir=/etc/mman \
		$(use_enable pam) \
		$(use_enable zlib) \
		|| die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "einstall failed"

	dodoc CHANGELOG COPYING
	dohtml README.html

	newconfd "${FILESDIR}"/conf.d/mman mman
	newinitd "${FILESDIR}"/init.d/mman mman
}

#pkg_preinst() {
#	enewgroup mman 8080
#	enewuser mman 8080
#}

pkg_postinst() {
	#einfo "A mman user has been added to your system if one did not already exist"
	einfo "-"
	einfo "Note: init/conf scripts and a sample config has been provided for you."
	einfo "They can be found at or in /etc/conf.d/mman /etc/init.d/mman /etc/mman/"
}

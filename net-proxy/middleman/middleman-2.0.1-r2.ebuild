# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-proxy/middleman/middleman-2.0.1-r2.ebuild,v 1.4 2006/04/14 09:20:26 mrness Exp $

inherit eutils

DESCRIPTION="Advanced HTTP/1.1 proxy server with features designed to increase privacy and remove unwanted content"
SRC_URI="mirror://sourceforge/middle-man/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/middle-man"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="pam zlib"

DEPEND="dev-libs/libpcre
	pam? ( sys-libs/pam )
	zlib? (	sys-libs/zlib )"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-putlog-fix.patch
	epatch "${FILESDIR}"/${P}-gcc-34.patch
}

src_compile() {
	econf \
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

	if [ -d /etc/mman/mman ]; then
		ewarn "A previous version of this ebuild installed the config scripts into"
		ewarn
		ewarn "    /etc/mman/mman/"
		ewarn
		ewarn "by mistake.  Please move these files into /etc/mman instead, and remove"
		ewarn "your /etc/mman/mman/ directory."
	fi
}

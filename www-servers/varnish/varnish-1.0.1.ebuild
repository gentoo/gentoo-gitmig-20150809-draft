# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/varnish/varnish-1.0.1.ebuild,v 1.1 2006/10/19 07:46:53 bangert Exp $

inherit eutils
DESCRIPTION="Varnish is an HTTP accelerator"
HOMEPAGE="http://varnish.linpro.no/"
SRC_URI="mirror://sourceforge/varnish/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"
src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd ${FILESDIR}/varnishd.initd varnishd || die
	newconfd ${FILESDIR}/varnishd.confd varnishd || die
}

pkg_postinst () {
	einfo "No demo-/sample-configfile is included in the distribution -"
	einfo "please read the man-page for more info."
	einfo "A sample (localhost:8080 -> localhost:80) for gentoo is given in"
	einfo "   /etc/conf.d/varnishd"
	echo
}


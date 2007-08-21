# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/varnish/varnish-1.1.1.ebuild,v 1.1 2007/08/21 06:40:13 bangert Exp $

inherit eutils
DESCRIPTION="Varnish is an HTTP accelerator"
HOMEPAGE="http://varnish.linpro.no/"
SRC_URI="mirror://sourceforge/varnish/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

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
	elog "No demo-/sample-configfile is included in the distribution -"
	elog "please read the man-page for more info."
	elog "A sample (localhost:8080 -> localhost:80) for gentoo is given in"
	elog "   /etc/conf.d/varnishd"
	echo
}

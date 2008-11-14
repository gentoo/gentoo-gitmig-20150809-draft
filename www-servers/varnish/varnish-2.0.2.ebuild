# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/varnish/varnish-2.0.2.ebuild,v 1.1 2008/11/14 14:59:09 bangert Exp $

DESCRIPTION="Varnish is a state-of-the-art, high-performance HTTP accelerator."
HOMEPAGE="http://varnish.projects.linpro.no/"
SRC_URI="mirror://sourceforge/varnish/${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
#varnish compiles stuff at run time
RDEPEND="sys-devel/gcc"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/varnishd.initd varnishd || die
	newconfd "${FILESDIR}"/varnishd.confd varnishd || die
}

pkg_postinst () {
	elog "No demo-/sample-configfile is included in the distribution -"
	elog "please read the man-page for more info."
	elog "A sample (localhost:8080 -> localhost:80) for gentoo is given in"
	elog "   /etc/conf.d/varnishd"
	echo
}

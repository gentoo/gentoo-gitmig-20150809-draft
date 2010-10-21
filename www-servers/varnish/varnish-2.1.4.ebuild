# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/varnish/varnish-2.1.4.ebuild,v 1.1 2010/10/21 21:43:30 bangert Exp $

EAPI="3"

inherit eutils autotools

DESCRIPTION="Varnish is a state-of-the-art, high-performance HTTP accelerator."
HOMEPAGE="http://www.varnish-cache.org/"
SRC_URI="http://www.varnish-software.com/sites/default/files/${P}.tar.gz"
LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
#varnish compiles stuff at run time
RDEPEND="sys-devel/gcc"
DEPEND="dev-python/docutils"

RESTRICT="test" #315725

src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.1.4-virtual-ncsa.patch
	epatch "${FILESDIR}"/${PN}-2.1.4-find-rst2man.py.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	newinitd "${FILESDIR}"/varnishd.initd varnishd || die
	newconfd "${FILESDIR}"/varnishd.confd varnishd || die

	insinto /etc/logrotate.d
	newins "${FILESDIR}/varnishd.logrotate" varnishd

	dodir /var/log/varnish

	use doc && dohtml -r "doc/sphinx/=build/html/"
}

pkg_postinst () {
	elog "No demo-/sample-configfile is included in the distribution -"
	elog "please read the man-page for more info."
	elog "A sample (localhost:8080 -> localhost:80) for gentoo is given in"
	elog "   /etc/conf.d/varnishd"
	echo
	ewarn "Varnish 2.1.x introduces VCL changes wrt. 2.0.x. See also"
	ewarn "http://www.varnish-cache.org/docs/2.1/reference/vcl.html"
}

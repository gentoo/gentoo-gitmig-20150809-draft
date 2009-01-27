# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/pound/pound-2.4.4.ebuild,v 1.1 2009/01/27 19:39:52 bangert Exp $

inherit flag-o-matic

MY_P="${P/p/P}"
DESCRIPTION="A http/https reverse-proxy and load-balancer."
SRC_URI="http://www.apsis.ch/pound/${MY_P}.tgz"
HOMEPAGE="http://www.apsis.ch/pound/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
IUSE="ssl dynscaler static"

DEPEND="ssl? ( dev-libs/openssl )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	use static && append-ldflags -static

	econf \
		$(use_with ssl) \
		$(use_enable dynscaler) \
		|| die "configure failed"

	emake || die "compile failed"
}

src_install() {
	dodir /usr/sbin
	cp "${S}"/pound "${D}"/usr/sbin/
	cp "${S}"/poundctl "${D}"/usr/sbin/

	doman pound.8
	doman poundctl.8
	dodoc README FAQ

	dodir /etc/init.d
	newinitd "${FILESDIR}"/pound.init-1.9 pound

	insinto /etc
	newins "${FILESDIR}"/pound-2.2.cfg pound.cfg
}

pkg_postinst() {
	elog "No demo-/sample-configfile is included in the distribution -"
	elog "read the man-page for more info."
	elog "A sample (localhost:8888 -> localhost:80) for gentoo is given in \"/etc/pound.cfg\"."
	echo
	ewarn "You will have to upgrade you configuration file, if you are"
	ewarn "upgrading from a version <= 2.0."
	echo
	ewarn "The 'WebDAV' config statement is no longer supported!"
	ewarn "Please adjust your configuration, if necessary."
	echo
}

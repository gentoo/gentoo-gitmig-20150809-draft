# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/monit/monit-5.1.1.ebuild,v 1.1 2010/04/30 07:41:40 patrick Exp $

DESCRIPTION="a utility for monitoring and managing daemons or similar programs running on a Unix system."
HOMEPAGE="http://mmonit.com/monit/"
SRC_URI="http://mmonit.com/monit/dist/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ssl"

RDEPEND="ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e '/^INSTALL_PROG/s/-s//' Makefile.in || die "sed failed in Makefile.in"
}

src_compile() {
	econf $(use_with ssl) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc CHANGES.txt CONTRIBUTORS FAQ.txt README*
	dohtml -r doc/*

	insinto /etc; insopts -m700; doins monitrc || die "doins monitrc failed"
	newinitd "${FILESDIR}"/monit.initd-5.0 monit || die "newinitd failed"
}

pkg_postinst() {
	elog "Sample configurations are available at:"
	elog "http://mmonit.com/monit/documentation/"
}

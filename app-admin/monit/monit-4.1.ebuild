# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/monit/monit-4.1.ebuild,v 1.2 2004/02/29 22:59:35 pyrania Exp $

DESCRIPTION="a utility for monitoring and managing daemons or similar programs running on a Unix system."
HOMEPAGE="http://www.tildeslash.com/monit/"
SRC_URI="http://www.tildeslash.com/monit/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="ssl"

RDEPEND="virtual/glibc
	ssl? ( dev-libs/openssl )"
DEPEND="${RDEPEND}
	sys-devel/flex
	sys-devel/bison"

src_compile() {

	econf `use_with ssl` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc CHANGES.txt CONTRIBUTORS FAQ.txt LICENSE README* STATUS
	dohtml -r doc/*

	insinto /etc
	insopts -m700
	doins monitrc
}

pkg_postinst() {
	einfo
	einfo "Sample configurations are available at"
	einfo "http://www.tildeslash.com/monit/examples.html"
	einfo
}

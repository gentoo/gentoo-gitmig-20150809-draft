# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/monit/monit-4.3.ebuild,v 1.3 2004/11/21 16:09:35 weeve Exp $

DESCRIPTION="a utility for monitoring and managing daemons or similar programs running on a Unix system."
HOMEPAGE="http://www.tildeslash.com/monit/"
SRC_URI="http://www.tildeslash.com/monit/dist/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~ppc sparc"
IUSE="ssl"

RDEPEND="virtual/libc
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

	dodoc CHANGES.txt CONTRIBUTORS FAQ.txt README* STATUS UPGRADE.txt
	dohtml -r doc/*

	insinto /etc; insopts -m700; doins monitrc || die
	exeinto /etc/init.d; newexe ${FILESDIR}/monit.initd monit || die
}

pkg_postinst() {
	einfo "Sample configurations are available at"
	einfo "http://www.tildeslash.com/monit/examples.html"
}

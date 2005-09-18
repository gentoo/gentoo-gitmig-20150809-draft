# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/libnss-mysql/libnss-mysql-1.4.ebuild,v 1.2 2005/09/18 03:13:54 weeve Exp $

DESCRIPTION="NSS MySQL Library."
HOMEPAGE="http://libnss-mysql.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=dev-db/mysql-3.2
	!sys-libs/nss-mysql"

src_install() {
	einstall libdir="${D}/lib"

	newdoc sample/README README.sample
	dodoc AUTHORS COPYING DEBUGGING FAQ INSTALL NEWS README THANKS \
		TODO UPGRADING ChangeLog

	for subdir in sample/{,complex,minimal} ; do
		docinto "${subdir}"
		dodoc "${subdir}/"{*.sql,*.cfg}
	done
}

pkg_postinst() {
	einfo "As of version 1.3, the [section] lines in the configuration files"
	einfo "are meaningless and will be ignored.  Remove them to avoid extra"
	einfo "parsing overhead."
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/dbskkd-cdb/dbskkd-cdb-1.01.ebuild,v 1.1 2003/05/05 09:29:38 phosphan Exp $

DESCRIPTION="Yet another Dictionary server for the SKK Japanese-input software"

HOMEPAGE="http://www.ne.jp/asahi/bdx/info/software/jp-dbskkd.html"
SRC_URI="http://www.ne.jp/asahi/bdx/info/software/${P}.tar.gz"

LICENSE="as-is"
SLOT="0"

KEYWORDS="~x86 ~ppc ~sparc ~alpha"

IUSE=""

PROVIDE="virtual/skkserv"

DEPEND="dev-db/freecdb"
RDEPEND="app-i18n/skk-jisyo-cdb
		virtual/inetd"

src_compile() {
	emake	SERVERDIR=/usr/sbin \
		COMPAT="-DJISHO_FILE=\\\"/usr/share/skk/SKK-JISYO.L.cdb\\\"" \
		LDFLAGS="-lutil -lfreecdb" \
		CC="cc ${CFLAGS}" || die
}

src_install() {
	dosbin dbskkd-cdb

	insinto /etc/xinetd.d
	newins ${FILESDIR}/dbskkd-cdb.xinetd dbskkd-cdb

	dodoc LICENSE Release-Notes.{English,Japanese}
}

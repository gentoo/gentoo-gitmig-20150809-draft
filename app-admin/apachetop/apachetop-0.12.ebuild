# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apachetop/apachetop-0.12.ebuild,v 1.9 2004/11/16 07:00:20 robbat2 Exp $

DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="http://clueful.shagged.org/apachetop/"
SRC_URI="http://clueful.shagged.org/apachetop/files/${P}.tar.gz"

IUSE="apache2 fam pcre"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ~mips ppc"

DEPEND="sys-apps/sed"
RDEPEND="sys-libs/libtermcap-compat
	fam? ( virtual/fam )
	pcre? ( dev-libs/libpcre )"

src_compile() {
	if use apache2
	then
		sed -i 's%DEFAULT_LOGFILE "/var/httpd/apache_log"%DEFAULT_LOGFILE "/var/log/apache2/access_log"%' src/apachetop.h
	else
		sed -i 's%DEFAULT_LOGFILE "/var/httpd/apache_log"%DEFAULT_LOGFILE "/var/log/apache/access_log"%' src/apachetop.h
	fi
	local myconf
	myconf="${myconf} $(use_with fam) $(use_with pcre)"
	econf ${myconf}
	emake || die
}

src_install() {
	dobin src/apachetop || die

	dodoc README INSTALL TODO AUTHORS ChangeLog NEWS
}

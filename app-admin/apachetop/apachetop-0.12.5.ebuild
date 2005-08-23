# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apachetop/apachetop-0.12.5.ebuild,v 1.6 2005/08/23 01:13:09 hparker Exp $

DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="http://clueful.shagged.org/apachetop/"
SRC_URI="http://clueful.shagged.org/apachetop/files/${P}.tar.gz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~mips ppc sparc x86"
IUSE="apache2 fam pcre adns"

DEPEND="sys-apps/sed
	sys-libs/readline
	sys-libs/ncurses
	fam? ( virtual/fam )
	pcre? ( dev-libs/libpcre )
	adns? ( net-libs/adns )"

src_compile() {
	useq apache2 && logfile="/var/log/apache2/access_log"
	useq apache2 || logfile="/var/log/apache/access_log"
	econf --with-logfile="${logfile}" `use_with fam` `use_with pcre` `use_with adns` || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README INSTALL TODO AUTHORS ChangeLog NEWS
}

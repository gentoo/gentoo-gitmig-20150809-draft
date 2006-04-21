# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apachetop/apachetop-0.12.6.ebuild,v 1.1 2006/04/21 17:55:24 rl03 Exp $

inherit eutils

DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="http://www.webta.org/projects/apachetop"
SRC_URI="http://www.webta.org/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~mips ~ppc ~sparc ~x86"
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
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}

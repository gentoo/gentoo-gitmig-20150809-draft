# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/apachetop/apachetop-0.12.5-r1.ebuild,v 1.7 2006/12/10 08:48:36 beu Exp $

inherit eutils

DESCRIPTION="A realtime Apache log analyzer"
HOMEPAGE="http://clueful.shagged.org/apachetop/"
SRC_URI="http://clueful.shagged.org/apachetop/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~mips ppc sparc x86"
IUSE="apache2 fam pcre adns"

DEPEND="fam? ( virtual/fam )
	pcre? ( dev-libs/libpcre )
	adns? ( net-libs/adns )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/CAN-2005-2660.patch
}

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

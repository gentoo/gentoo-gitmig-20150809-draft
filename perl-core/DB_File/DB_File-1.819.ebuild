# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/DB_File/DB_File-1.819.ebuild,v 1.2 2009/12/16 21:46:20 abcd Exp $

MODULE_AUTHOR=PMQS
inherit perl-module multilib eutils

DESCRIPTION="A Berkeley DB Support Perl Module"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-lang/perl
		sys-libs/db"

SRC_TEST="do"

src_unpack() {
	unpack ${A}
	if [ $(get_libdir) != "lib" ] ; then
		sed -i "s:^LIB.*:LIB = /usr/$(get_libdir):" "${S}"/config.in || die
	fi
	cd "${S}"
	epatch "${FILESDIR}"/DB_File-MakeMaker.patch
}

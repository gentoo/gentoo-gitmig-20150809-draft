# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header : $

inherit perl-module

DESCRIPTION="Mysql top monitors a MySQL server"
HOMEPAGE="http://mtop.sourceforge.net"
SRC_URI="mirror://sourceforge/mtop/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-perl/Curses
		dev-perl/DBI
		dev-perl/DBD-mysql
		dev-perl/libnet"

src_compile() {
	perl-module_src_prep || die "Perl module preparation failed."
	perl-module_src_compile || die "Perl module compilation failed."
	perl-module_src_test || die "Perl module tests failed."
}

src_install() {
	perl-module_src_install || die "Perl module installation failed."
	dodoc ChangeLog COPYING README README.devel
}


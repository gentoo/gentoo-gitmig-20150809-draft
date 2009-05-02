# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Socket-SSL/IO-Socket-SSL-1.24.ebuild,v 1.2 2009/05/02 08:09:07 tove Exp $

EAPI=2

MODULE_AUTHOR=SULLR
inherit perl-module

DESCRIPTION="Nearly transparent SSL encapsulation for IO::Socket::INET"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

DEPEND="
	>=dev-perl/Net-SSLeay-1.33
	virtual/perl-Scalar-List-Utils
	dev-perl/Net-LibIDN"

SRC_TEST="do"

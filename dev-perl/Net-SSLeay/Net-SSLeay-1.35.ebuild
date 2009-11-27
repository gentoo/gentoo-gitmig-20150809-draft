# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-SSLeay/Net-SSLeay-1.35.ebuild,v 1.9 2009/11/27 10:31:55 tove Exp $

MODULE_AUTHOR=FLORA
inherit perl-module

DESCRIPTION="Net::SSLeay module for perl"

LICENSE="openssl"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc ~sparc-fbsd x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-libs/openssl
	dev-lang/perl"
DEPEND="${RDEPEND}"
#	test? ( dev-perl/Test-Exception
#		dev-perl/Test-Warn
#		dev-perl/Test-NoWarnings )"

#SRC_TEST=do

export OPTIMIZE="$CFLAGS"

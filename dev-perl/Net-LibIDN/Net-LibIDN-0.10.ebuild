# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-LibIDN/Net-LibIDN-0.10.ebuild,v 1.9 2008/08/26 06:29:03 jer Exp $

MODULE_AUTHOR=THOR
inherit perl-module

DESCRIPTION="Perl bindings for GNU Libidn"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc64 ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl
	net-dns/libidn"

SRC_TEST=do

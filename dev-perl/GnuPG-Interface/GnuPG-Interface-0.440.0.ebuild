# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GnuPG-Interface/GnuPG-Interface-0.440.0.ebuild,v 1.1 2011/05/03 18:44:15 tove Exp $

EAPI=4

MODULE_AUTHOR=JESSE
MODULE_VERSION=0.44
inherit perl-module

DESCRIPTION="GnuPG::Interface is a Perl module interface to interacting with GnuPG."

SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~ppc-macos"
IUSE=""

RDEPEND=">=app-crypt/gnupg-1.2.1-r1
	>=virtual/perl-Math-BigInt-1.78
	dev-perl/Any-Moose"
DEPEND="${RDEPEND}"

SRC_TEST="do"

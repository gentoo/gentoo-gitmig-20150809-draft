# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GnuPG-Interface/GnuPG-Interface-0.42.ebuild,v 1.9 2010/08/28 17:09:32 armin76 Exp $

EAPI=2

MODULE_AUTHOR=JESSE
inherit perl-module

DESCRIPTION="GnuPG::Interface is a Perl module interface to interacting with GnuPG."

SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=app-crypt/gnupg-1.2.1-r1
	dev-perl/Any-Moose"
DEPEND="${RDEPEND}"

SRC_TEST="do"

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RegExp/XML-RegExp-0.03-r1.ebuild,v 1.21 2010/01/14 18:22:00 grobian Exp $

MODULE_AUTHOR=TJMATHER
inherit perl-module

DESCRIPTION="Regular expressions for XML tokens"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~arm hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/XML-Parser-2.29
	dev-lang/perl"

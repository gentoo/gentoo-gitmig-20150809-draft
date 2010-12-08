# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Rcs/Rcs-1.05.ebuild,v 1.1 2010/12/08 12:55:43 chainsaw Exp $

EAPI="2"

MODULE_AUTHOR=CFRETER
inherit perl-module

DESCRIPTION="Perl bindings for Revision Control System"
HOMEPAGE="http://search.cpan.org/~cfreter/Rcs-1.05/"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="dev-lang/perl
	 dev-vcs/rcs"
DEPEND="${RDEPEND}"

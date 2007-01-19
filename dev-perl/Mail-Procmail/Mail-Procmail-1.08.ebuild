# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Procmail/Mail-Procmail-1.08.ebuild,v 1.12 2007/01/19 14:04:21 mcummings Exp $

inherit perl-module

DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="mirror://cpan/authors/id/J/JV/JV/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jv/"

SRC_TEST="do"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="virtual/perl-Getopt-Long
	>=dev-perl/MailTools-1.15
	>=dev-perl/LockFile-Simple-0.2.5
	dev-lang/perl"

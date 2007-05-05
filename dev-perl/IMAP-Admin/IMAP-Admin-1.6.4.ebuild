# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IMAP-Admin/IMAP-Admin-1.6.4.ebuild,v 1.4 2007/05/05 18:19:19 ticho Exp $

inherit perl-module
DESCRIPTION="IMAP::Admin - Perl module for basic IMAP server administration"
HOMEPAGE="http://search.cpan.org/~eestabroo/"
SRC_URI="mirror://cpan/authors/id/E/EE/EESTABROO/${P}.tar.gz"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-lang/perl"

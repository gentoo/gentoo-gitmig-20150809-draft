# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTPD-User-Manage/HTTPD-User-Manage-1.66.ebuild,v 1.4 2007/07/11 15:52:51 armin76 Exp $

inherit perl-module

DESCRIPTION="Perl module for managing access control of web servers"
SRC_URI="mirror://cpan/authors/id/L/LD/LDS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/L/LD/LDS/${P}.readme"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"

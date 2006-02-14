# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-Session/CGI-Session-4.03.ebuild,v 1.5 2006/02/14 19:10:44 anarchy Exp $

inherit perl-module

DESCRIPTION="persistent session data in CGI applications "
HOMEPAGE="http://search.cpan.org/~HOME/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SH/SHERZODR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc sparc x86 ~amd64"
IUSE=""

SRC_TEST="do"

DEPEND="virtual/perl-Digest-MD5"

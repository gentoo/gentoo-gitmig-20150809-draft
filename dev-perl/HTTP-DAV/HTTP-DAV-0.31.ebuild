# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-DAV/HTTP-DAV-0.31.ebuild,v 1.1 2004/03/29 11:37:49 mcummings Exp $

inherit perl-module

DESCRIPTION="A WebDAV client library for Perl5"
HOMEPAGE="http://search.cpan.org/~pcollins/${P}/"
SRC_URI="http://www.cpan.org/authors/id/P/PC/PCOLLINS/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

SRC_TEST="do"

DEPEND="dev-perl/libwww-perl
		dev-perl/XML-DOM"

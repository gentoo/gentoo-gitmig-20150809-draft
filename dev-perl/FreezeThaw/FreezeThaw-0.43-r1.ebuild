# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/FreezeThaw/FreezeThaw-0.43-r1.ebuild,v 1.14 2006/08/05 04:05:13 mcummings Exp $

inherit perl-module

DESCRIPTION="converting Perl structures to strings and back"
SRC_URI="mirror://cpan/authors/id/I/IL/ILYAZ/modules/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${P}.readme"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 hppa ppc sparc alpha ia64 s390"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

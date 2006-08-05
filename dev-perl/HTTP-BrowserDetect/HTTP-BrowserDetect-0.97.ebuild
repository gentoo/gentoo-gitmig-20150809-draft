# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-BrowserDetect/HTTP-BrowserDetect-0.97.ebuild,v 1.9 2006/08/05 04:34:38 mcummings Exp $

inherit perl-module

DESCRIPTION="Detect browser, version, OS from UserAgent"
SRC_URI="mirror://cpan/authors/id/L/LH/LHS/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/L/LH/LHS/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 amd64 alpha ~hppa ~mips ~ppc sparc"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"

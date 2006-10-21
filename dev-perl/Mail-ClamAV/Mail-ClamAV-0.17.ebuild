# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-ClamAV/Mail-ClamAV-0.17.ebuild,v 1.8 2006/10/21 00:27:19 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for the clamav virus scanner."
HOMEPAGE="http://search.cpan.org/~sabeck/${P}"
SRC_URI="mirror://cpan/authors/id/S/SA/SABECK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 sparc x86"

IUSE=""

DEPEND=">=app-antivirus/clamav-0.80
	dev-perl/Inline
	dev-lang/perl"

RDEPEND="${DEPEND}"

src_install() {
	perl-module_src_install
	dodoc README Changes || die
}





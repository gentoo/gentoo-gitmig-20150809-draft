# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RegExp/XML-RegExp-0.03-r1.ebuild,v 1.10 2005/05/18 08:47:41 corsair Exp $

inherit perl-module

DESCRIPTION="A Perl module which contains contains regular expressions for the following XML tokens: BaseChar, Ideographic, Letter, Digit, Extender, CombiningChar, NameChar, EntityRef, CharRef, Reference, Name, NmToken, and AttValue."
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/XML/XML-RegExp-0.03.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ppc64"
IUSE=""

SRC_TEST="do"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29"

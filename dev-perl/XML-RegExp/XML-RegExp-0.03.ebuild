# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RegExp/XML-RegExp-0.03.ebuild,v 1.13 2004/06/25 01:12:59 agriffis Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="A Perl module which contains contains regular expressions for
the following XML tokens: BaseChar, Ideographic, Letter, Digit, Extender,
CombiningChar, NameChar, EntityRef, CharRef, Reference, Name, NmToken, and
AttValue."
SRC_URI="http://cpan.org/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/XML/XML-RegExp-0.03.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29"

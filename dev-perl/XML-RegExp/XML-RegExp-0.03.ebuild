# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RegExp/XML-RegExp-0.03.ebuild,v 1.4 2002/07/25 04:56:39 seemant Exp $

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
KEYWORDS="x86"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29"

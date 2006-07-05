# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-RegExp/XML-RegExp-0.03-r1.ebuild,v 1.16 2006/07/05 13:37:28 ian Exp $

inherit perl-module

DESCRIPTION="A Perl module which contains contains regular expressions for the following XML tokens: BaseChar, Ideographic, Letter, Digit, Extender, CombiningChar, NameChar, EntityRef, CharRef, Reference, Name, NmToken, and AttValue."
SRC_URI="mirror://cpan/authors/id/T/TJ/TJMATHER/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/XML/XML-RegExp-0.03.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/XML-Parser-2.29"
RDEPEND="${DEPEND}"
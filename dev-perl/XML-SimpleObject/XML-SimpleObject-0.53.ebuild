# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-SimpleObject/XML-SimpleObject-0.53.ebuild,v 1.14 2010/01/29 14:15:30 tove Exp $

EAPI=2

MODULE_AUTHOR=DBRIAN
inherit perl-module

DESCRIPTION="A Perl XML Simple package."

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

RDEPEND=">=dev-perl/XML-Parser-2.30
	>=dev-perl/XML-LibXML-1.54"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}${PV}

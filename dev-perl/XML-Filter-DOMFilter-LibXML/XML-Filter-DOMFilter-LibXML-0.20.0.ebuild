# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Filter-DOMFilter-LibXML/XML-Filter-DOMFilter-LibXML-0.20.0.ebuild,v 1.2 2011/09/03 21:05:04 tove Exp $

EAPI=4

MODULE_AUTHOR=PAJAS
MODULE_VERSION=0.02
inherit perl-module

DESCRIPTION="SAX Filter allowing DOM processing of selected subtrees"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc ~x86"
IUSE=""

RDEPEND=">=dev-perl/XML-LibXML-1.53"
DEPEND="${RDEPEND}"

SRC_TEST="do"

# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/XML-XSH2/XML-XSH2-2.1.1.ebuild,v 1.2 2010/10/30 10:07:24 ssuominen Exp $

MODULE_AUTHOR=PAJAS
inherit perl-module

DESCRIPTION="XML Editing Shell"
HOMEPAGE="http://xsh.sourceforge.net/"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/XML-LibXML-1.61
	>=dev-perl/Parse-RecDescent-1.94
	>=dev-perl/XML-LibXSLT-1.53
	dev-perl/IO-stringy
	dev-perl/XML-SAX-Writer
	dev-perl/Term-ReadLine-Perl
	dev-perl/XML-Filter-DOMFilter-LibXML
	>=dev-perl/XML-XUpdate-LibXML-0.4.0
	!app-editors/XML-XSH"

SRC_TEST=do

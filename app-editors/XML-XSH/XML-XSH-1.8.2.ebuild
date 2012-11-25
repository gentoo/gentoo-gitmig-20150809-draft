# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/XML-XSH/XML-XSH-1.8.2.ebuild,v 1.9 2012/11/25 17:14:58 ago Exp $

inherit perl-module

DESCRIPTION="XML Editing Shell"
HOMEPAGE="http://xsh.sourceforge.net/"
SRC_URI="mirror://sourceforge/xsh/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 x86"
IUSE=""

DEPEND=">=dev-perl/XML-LibXML-1.61
	dev-perl/Parse-RecDescent
	dev-perl/Text-Iconv
	dev-perl/XML-LibXSLT
	dev-perl/Term-ReadLine-Perl
	dev-perl/XML-XUpdate-LibXML
	!app-editors/XML-XSH2"

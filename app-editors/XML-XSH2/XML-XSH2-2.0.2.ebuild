# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/XML-XSH2/XML-XSH2-2.0.2.ebuild,v 1.4 2006/10/20 21:22:08 mcummings Exp $

inherit perl-module

DESCRIPTION="XML Editing Shell"
HOMEPAGE="http://xsh.sourceforge.net/"
SRC_URI="mirror://sourceforge/xsh/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND=">=dev-perl/XML-LibXML-1.56
	>=dev-perl/Parse-RecDescent-1.94
	>=dev-perl/XML-LibXSLT-1.53
	dev-perl/Term-ReadLine-Perl
	>=dev-perl/XML-XUpdate-LibXML-0.4.0
	>=dev-perl/XML-LibXML-XPathContext-0.04
	!app-editors/XML-XSH"

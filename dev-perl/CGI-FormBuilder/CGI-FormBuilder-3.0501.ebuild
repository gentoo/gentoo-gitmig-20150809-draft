# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CGI-FormBuilder/CGI-FormBuilder-3.0501.ebuild,v 1.1 2008/07/30 08:21:09 tove Exp $

inherit perl-module

DESCRIPTION="Extremely fast, reliable form generation and processing module"
HOMEPAGE="http://www.formbuilder.org/ http://search.cpan.org/dist/CGI-FormBuilder/"
SRC_URI="mirror://cpan/authors/id/N/NW/NWIGER/${P}.tgz
	http://www.formbuilder.org/download/${P}.tgz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

# Templates that can be used - but they are optional
#	>=dev-perl/HTML-Template-2.06
#	>=dev-perl/text-template-1.43
#	>=dev-perl/CGI-FastTemplate-1.09
#	>=dev-perl/Template-Toolkit-2.08

SRC_TEST=do

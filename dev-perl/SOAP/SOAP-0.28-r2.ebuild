# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SOAP/SOAP-0.28-r2.ebuild,v 1.8 2004/07/14 20:25:49 agriffis Exp $

inherit perl-module

DESCRIPTION="A Perl Module for SOAP"
SRC_URI="http://cpan.valueclick.com/modules/by-module/SOAP/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/SOAP/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha"
IUSE=""

DEPEND="${DEPEND}
	dev-perl/libwww-perl
	>=dev-perl/XML-Parser-2.29
	>=dev-perl/mod_perl-1.24"

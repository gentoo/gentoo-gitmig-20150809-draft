# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Amazon/Net-Amazon-0.35.ebuild,v 1.3 2006/06/29 06:32:52 ian Exp $

inherit perl-module

DESCRIPTION="Net::Amazon - Framework for accessing amazon.com via SOAP and XML/HTTP"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHILLI/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MS/MSCHILLI/Net-Amazon-0.35.readme"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86"

DEPEND="dev-perl/libwww-perl
	>=dev-perl/XML-Simple-2.08
	>=perl-core/Time-HiRes-1.0
	>=dev-perl/Log-Log4perl-0.3"
RDEPEND="${DEPEND}"

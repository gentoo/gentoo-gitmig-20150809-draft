# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-LibXML-Common/XML-LibXML-Common-0.13.ebuild,v 1.15 2006/05/14 10:30:25 flameeyes Exp $

IUSE=""

inherit perl-module

DESCRIPTION="Routines and Constants common for XML::LibXML and XML::GDOME."
SRC_URI="mirror://cpan/authors/id/P/PH/PHISH/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/XML/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~hppa ia64 ~mips ppc ppc64 sparc x86 ~x86-fbsd"

DEPEND="${DEPEND}
	>=dev-libs/libxml2-2.4.1"

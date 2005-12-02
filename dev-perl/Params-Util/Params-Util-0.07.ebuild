# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Params-Util/Params-Util-0.07.ebuild,v 1.2 2005/12/02 09:19:48 josejx Exp $

inherit perl-module

DESCRIPTION="Utility funcions to aid in parameter checking"
HOMEPAGE="http://search.cpan.org/search?module=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Scalar-List-Utils-1.11"

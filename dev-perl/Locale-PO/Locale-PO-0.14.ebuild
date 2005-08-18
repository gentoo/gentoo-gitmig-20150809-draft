# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-PO/Locale-PO-0.14.ebuild,v 1.3 2005/08/18 18:45:20 hansmi Exp $

inherit perl-module

DESCRIPTION="Object-oriented interface to gettext po-file entries"
SRC_URI="mirror://cpan/authors/id/A/AL/ALANSZ/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~alansz/${P}/"

DEPEND="${DEPEND}
	sys-devel/gettext"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ppc ~ppc64 ~s390 sparc x86"
IUSE=""

SRC_TEST="do"

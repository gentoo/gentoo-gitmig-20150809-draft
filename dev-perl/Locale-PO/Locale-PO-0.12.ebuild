# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-PO/Locale-PO-0.12.ebuild,v 1.1 2004/10/19 11:05:39 mcummings Exp $

inherit perl-module

DESCRIPTION="Object-oriented interface to gettext po-file entries"
SRC_URI="mirror://cpan/authors/id/A/AL/ALANSZ/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~alansz/${P}/"

DEPEND="${DEPEND}
	sys-devel/gettext"
RDEPEND="${DEPEND}"
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~s390"
IUSE=""

SRC_TEST="do"

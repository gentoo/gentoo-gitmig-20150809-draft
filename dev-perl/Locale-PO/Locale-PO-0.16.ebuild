# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-PO/Locale-PO-0.16.ebuild,v 1.9 2006/07/04 11:42:50 ian Exp $

inherit perl-module

DESCRIPTION="Object-oriented interface to gettext po-file entries"
HOMEPAGE="http://search.cpan.org/~alansz/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AL/ALANSZ/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ia64 m68k ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND="sys-devel/gettext"
RDEPEND="${DEPEND}"

SRC_TEST="do"
# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-Catalog/XML-Catalog-0.02-r1.ebuild,v 1.1 2002/05/06 16:48:46 seemant Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Module"
SRC_URI="http://cpan.valueclick.com/modules/by-module/XML/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/XML/${P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/XML-Parser-2.29
	>=dev-perl/libwww-perl-5.48"

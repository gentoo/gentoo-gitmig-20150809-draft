# Copyright 2002 Arcady Genkin <agenkin@thpoon.com>
# Distributed under the terms of the GNU General Public License, v2
# Author: Arcady Genkin <agenkin@thpoon.com>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-5.40-r1.ebuild,v 1.1 2002/05/05 16:02:26 seemant Exp $

# Inherit from perl-module.eclass
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

DESCRIPTION="Perl date manipulation routines."
HOMEPAGE="http://www.perl.com/CPAN/authors/id/SBECK/${P}.readme"
SRC_URI="http://www.perl.com/CPAN/authors/id/SBECK/${P}.tar.gz"

mydoc="HISTORY TODO"

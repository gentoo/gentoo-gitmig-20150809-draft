# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TimeDate/TimeDate-1.11-r1.ebuild,v 1.1 2002/05/06 15:57:12 seemant Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

DESCRIPTION="A Date/Time Parsing Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Date/${P}.readme"

SRC_URI="http://www.cpan.org/modules/by-module/Date/${P}.tar.gz"

mymake="/usr"

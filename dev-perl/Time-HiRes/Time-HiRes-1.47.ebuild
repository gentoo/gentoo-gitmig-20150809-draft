# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-HiRes/Time-HiRes-1.47.ebuild,v 1.1 2003/05/25 01:59:16 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Perl Time::HiRes. High resolution alarm, sleep, gettimeofday, interval timers" 
SRC_URI="http://search.cpan.org/CPAN/authors/id/J/JH/JHI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/author/JHI/${P}/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha ~mips ~hppa ~arm"
DEPEND=""
RDEPEND=""


mydoc="TODO"

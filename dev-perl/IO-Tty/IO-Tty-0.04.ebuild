# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tty/IO-Tty-0.04.ebuild,v 1.1 2002/05/11 17:40:00 agenkin Exp $

DESCRIPTION="IO::Tty and IO::Pty modules for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/G/GB/GBARR/${P}.readme"

S=${WORKDIR}/${P}
SRC_URI="http://cpan.valueclick.com/authors/id/G/GB/GBARR/${P}.tar.gz"

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

mymake="/usr"

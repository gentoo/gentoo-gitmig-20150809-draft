# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Tail/File-Tail-0.98-r2.ebuild,v 1.11 2003/02/13 11:07:45 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="File::Tail module for perl"
SRC_URI="http://www.cpan.org/authors/id/MGRABNAR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/MGRABNAR/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="${DEPEND} dev-perl/Time-HiRes"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"

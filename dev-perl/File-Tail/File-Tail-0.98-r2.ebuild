# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Tools Team <tools@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Tail/File-Tail-0.98-r2.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="File::Tail module for perl"
SRC_URI="http://www.cpan.org/authors/id/MGRABNAR/${P}.tar.gz"
DEPEND="${DEPEND} dev-perl/Time-HiRes"
LICENSE="Artistic | GPL-2"
SLOT="0"

export OPTIMIZE="$CFLAGS"
mydoc="ToDo"

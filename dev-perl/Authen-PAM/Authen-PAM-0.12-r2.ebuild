# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Tools Team <tools@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Authen-PAM/Authen-PAM-0.12-r2.ebuild,v 1.1 2002/05/05 14:08:57 seemant Exp $

# Inherit the perl-module.eclass functions
. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="The Perl DBD:mysql Module"
SRC_URI="http://www.cs.kuleuven.ac.be/~pelov/pam/download/${P}.tar.gz"

DEPEND="virtual/glibc >=sys-devel/perl-5 sys-libs/pam"
LICENSE="Artistic | GPL-2"
SLOT="0"
export OPTIMIZE="$CFLAGS"

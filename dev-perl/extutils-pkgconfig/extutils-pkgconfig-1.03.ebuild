# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/extutils-pkgconfig/extutils-pkgconfig-1.03.ebuild,v 1.1 2004/03/29 14:30:54 mcummings Exp $

inherit perl-module

MY_P=ExtUtils-PkgConfig-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Converts Perl XS code into C code"
HOMEPAGE="http://search.cpan.org/~rmcfarla/${MY_P}"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RM/RMCFARLA/Gtk2-Perl/${MY_P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64"

# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20020425.ebuild,v 1.1 2002/05/15 19:18:47 agenkin Exp $

DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
LICENSE="GPL-2"

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tgz"
S=${WORKDIR}/${P/perltidy/Perl-Tidy}

DEPEND=">=sys-devel/perl-5"

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

mymake="/usr"

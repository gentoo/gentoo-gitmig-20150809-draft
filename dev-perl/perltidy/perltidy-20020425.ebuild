# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20020425.ebuild,v 1.2 2002/05/21 18:14:08 danarmak Exp $

DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
LICENSE="GPL-2"

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tgz"
S=${WORKDIR}/${P/perltidy/Perl-Tidy}

DEPEND=">=sys-devel/perl-5"


inherit perl-module

mymake="/usr"

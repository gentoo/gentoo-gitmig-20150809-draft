# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/perltidy/perltidy-20020425.ebuild,v 1.3 2002/07/25 04:13:27 seemant Exp $

DESCRIPTION="Perl script indenter and beautifier."
HOMEPAGE="http://perltidy.sourceforge.net/"
LICENSE="GPL-2"

SRC_URI="http://unc.dl.sourceforge.net/sourceforge/perltidy/${P/perltidy/Perl-Tidy}.tgz"
SLOT="0"
S=${WORKDIR}/${P/perltidy/Perl-Tidy}

SLOT="0"
DEPEND=">=sys-devel/perl-5"


inherit perl-module

mymake="/usr"

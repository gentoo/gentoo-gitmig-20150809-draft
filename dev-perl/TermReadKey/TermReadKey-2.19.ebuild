# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TermReadKey/TermReadKey-2.19.ebuild,v 1.2 2002/05/21 18:14:08 danarmak Exp $

DESCRIPTION="Change terminal modes, and perform non-blocking reads."
HOMEPAGE="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.readme"


SRC_URI="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.tar.gz"
S=${WORKDIR}/${P}


inherit perl-module

mymake="/usr"

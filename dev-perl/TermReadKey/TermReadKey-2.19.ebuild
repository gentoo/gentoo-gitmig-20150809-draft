# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TermReadKey/TermReadKey-2.19.ebuild,v 1.4 2002/07/25 04:13:27 seemant Exp $

DESCRIPTION="Change terminal modes, and perform non-blocking reads."
HOMEPAGE="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.readme"


SRC_URI="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.tar.gz"
SLOT="0"
S=${WORKDIR}/${P}


inherit perl-module

mymake="/usr"

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TermReadKey/TermReadKey-2.19.ebuild,v 1.5 2002/07/25 04:56:38 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Change terminal modes, and perform non-blocking reads."
HOMEPAGE="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.readme"
SRC_URI="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86"

mymake="/usr"

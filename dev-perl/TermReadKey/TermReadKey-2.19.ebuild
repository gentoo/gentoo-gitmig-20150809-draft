# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TermReadKey/TermReadKey-2.19.ebuild,v 1.1 2002/05/11 17:53:01 agenkin Exp $

DESCRIPTION="Change terminal modes, and perform non-blocking reads."
HOMEPAGE="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.readme"


SRC_URI="http://cpan.valueclick.com/authors/id/J/JS/JSTOWE/${P}.tar.gz"
S=${WORKDIR}/${P}

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

mymake="/usr"

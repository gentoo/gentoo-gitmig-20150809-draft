# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Matthew Kennedy <mkennedy@gentoo.org>
# Author: phoen][x <eqc_phoenix@gmx.de>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-0.85-r1.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

# Inherit from perl-module.eclass

inherit perl-module

S=${WORKDIR}/${P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Event Module"
SRC_URI="http://www.cpan.org/modules/by-module/Event/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Event/${P}.readme"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"

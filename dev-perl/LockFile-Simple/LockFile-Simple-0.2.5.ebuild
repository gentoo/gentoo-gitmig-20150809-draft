# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Jerry Alexandratos <jerry@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/LockFile-Simple/LockFile-Simple-0.2.5.ebuild,v 1.3 2002/05/05 16:02:27 seemant Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="File locking module for Perl"
SRC_URI="http://www.cpan.org/modules/by-module/LockFile/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/LockFile/${P}.readme"

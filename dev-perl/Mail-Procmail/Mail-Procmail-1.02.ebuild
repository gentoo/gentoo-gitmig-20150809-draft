# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Mail-Procmail/Mail-Procmail-1.02.ebuild,v 1.4 2002/07/25 04:13:26 seemant Exp $


inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Mail sorting/delivery module for Perl."
SRC_URI="http://www.cpan.org/modules/by-module/Mail/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Mail/${P}.readme"

SLOT="0"
DEPEND="${DEPEND}
        >=dev-perl/MailTools-1.15
        >=dev-perl/LockFile-Simple-0.2.5"

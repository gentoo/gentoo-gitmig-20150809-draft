# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Locale-gettext/Locale-gettext-1.01-r1.ebuild,v 1.7 2004/03/03 02:10:32 iggy Exp $

inherit perl-module

MY_P="gettext-${PV}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A Perl module for accessing the GNU locale utilities"
HOMEPAGE="http://cpan.org/modules/by-module/Locale/${MY_P}.readme"
SRC_URI="http://cpan.org/modules/by-module/Locale/${MY_P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 amd64 sparc ~ppc ~alpha s390"

DEPEND="sys-devel/gettext"

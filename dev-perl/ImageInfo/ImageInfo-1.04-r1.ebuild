# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ImageInfo/ImageInfo-1.04-r1.ebuild,v 1.1 2002/05/05 16:02:27 seemant Exp $

. /usr/portage/eclass/inherit.eclass || die
inherit perl-module

MY_P=Image-Info-${PV}
S=${WORKDIR}/${MY_P}
CATEGORY="dev-perl"
DESCRIPTION="The Perl Image-Info Module"
SRC_URI="http://www.cpan.org/modules/by-module/Image/${MY_P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Image/${MY_P}.readme"

DEPEND="${DEPEND}
	>=dev-perl/IO-String-1.01"

mydoc="ToDo"

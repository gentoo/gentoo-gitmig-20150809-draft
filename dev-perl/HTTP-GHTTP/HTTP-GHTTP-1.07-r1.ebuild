# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-GHTTP/HTTP-GHTTP-1.07-r1.ebuild,v 1.8 2004/03/20 10:12:41 kumba Exp $

inherit perl-module

DESCRIPTION="simple interface to the Gnome project's libghttp"
SRC_URI="http://cpan.valueclick.com/modules/by-module/HTTP/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/HTTP/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ~mips"

newdepend ">=gnome-base/libghttp-1.0.9-r1"

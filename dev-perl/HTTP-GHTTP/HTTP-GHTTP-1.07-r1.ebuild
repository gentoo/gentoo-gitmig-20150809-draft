# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-GHTTP/HTTP-GHTTP-1.07-r1.ebuild,v 1.11 2004/07/14 17:56:41 agriffis Exp $

inherit perl-module

DESCRIPTION="simple interface to the Gnome project's libghttp"
SRC_URI="http://cpan.valueclick.com/modules/by-module/HTTP/${P}.tar.gz"
HOMEPAGE="http://cpan.valueclick.com/modules/by-module/HTTP/${P}.readme"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ~mips"
IUSE=""

DEPEND=">=gnome-base/libghttp-1.0.9-r1"

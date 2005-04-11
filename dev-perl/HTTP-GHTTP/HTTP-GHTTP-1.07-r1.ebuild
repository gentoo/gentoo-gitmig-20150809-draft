# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTTP-GHTTP/HTTP-GHTTP-1.07-r1.ebuild,v 1.13 2005/04/11 19:17:40 corsair Exp $

inherit perl-module

DESCRIPTION="simple interface to the Gnome project's libghttp"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~msergeant/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 amd64 ppc sparc alpha ~mips ~ppc64"
IUSE=""

DEPEND=">=gnome-base/libghttp-1.0.9-r1"

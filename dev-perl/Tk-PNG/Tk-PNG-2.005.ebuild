# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tk-PNG/Tk-PNG-2.005.ebuild,v 1.4 2004/10/16 23:57:23 rac Exp $

inherit perl-module

DESCRIPTION="A Perl Module to load PNG files with Tk::Photo"
SRC_URI="http://cpan.org/modules/by-module/Tk/${P}.tar.gz"
HOMEPAGE="http://cpan.org/modules/by-module/Tk/${P}.readme"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~ia64"
IUSE=""

DEPEND=">=dev-perl/perl-tk-800.024-r2
	>=media-libs/libpng-1.2.5-r4
	>=sys-libs/zlib-1.1.4-r1"

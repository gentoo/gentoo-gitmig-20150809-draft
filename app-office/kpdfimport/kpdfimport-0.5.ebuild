# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/kpdfimport/kpdfimport-0.5.ebuild,v 1.3 2004/06/24 22:42:11 agriffis Exp $

inherit kde-base
need-kde 3

DESCRIPTION="A pdf import filter for koffice (kword only for the moment)"
SRC_URI="mirror://sourceforge/kpdfimport/${P}.tar.bz2"
HOMEPAGE="http://sourceforge.net/projects/kpdfimport/"

KEYWORDS="~x86 ~ppc"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND=">=app-office/koffice-1.2"


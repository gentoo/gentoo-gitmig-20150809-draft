# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/kdar/kdar-1.3.2.ebuild,v 1.2 2005/02/06 02:51:15 matsuu Exp $

inherit kde
need-kde 3.3

DESCRIPTION="the KDE Disk Archiver"
HOMEPAGE="http://kdar.sourceforge.net/"
SRC_URI="mirror://sourceforge/kdar/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

DEPEND="${DEPEND}
	=app-arch/dar-2.1*
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4"
RDEPEND="${RDEPEND}
	=app-arch/dar-2.1*"


# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-antivirus/klamav/klamav-0.17.3.ebuild,v 1.1 2005/05/13 10:05:13 greg_g Exp $

inherit kde

DESCRIPTION="KDE frontend for the ClamAV antivirus."
HOMEPAGE="http://klamav.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

DEPEND="app-antivirus/clamav"

need-kde 3

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/enca/enca-1.9.ebuild,v 1.9 2006/12/26 13:32:25 drizzt Exp $

DESCRIPTION="ENCA detects the character coding of a file and converts it if desired"
HOMEPAGE="http://trific.ath.cx/software/enca/"
SRC_URI="http://trific.ath.cx/Ftp/enca/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""

src_install() {
	make DESTDIR=${D} install || die
}

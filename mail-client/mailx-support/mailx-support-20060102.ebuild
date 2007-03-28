# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mailx-support/mailx-support-20060102.ebuild,v 1.2 2007/03/28 22:31:02 ticho Exp $

inherit eutils

DESCRIPTION="Provides lockspool utility"
HOMEPAGE="http://www.openbsd.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
SRC_URI="mirror://gentoo/${P}.tar.bz2"
DEPEND=""
RDEPEND=""

src_compile() {
	emake
}

src_install() {
	einstall
}

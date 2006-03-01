# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/mailx-support/mailx-support-20060102.ebuild,v 1.1 2006/03/01 16:16:34 langthang Exp $

inherit eutils

DESCRIPTION="Provides mail.local and lockspool"
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

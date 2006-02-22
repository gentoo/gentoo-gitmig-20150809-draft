# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cvsutils/cvsutils-0.2.3.ebuild,v 1.1 2006/02/22 14:08:25 lostlogic Exp $

inherit eutils
DESCRIPTION="A small bundle of utilities to work with CVS repositories"
HOMEPAGE="http://www.red-bean.com/cvsutils/"
SRC_URI="http://www.red-bean.com/cvsutils/releases/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
DEPEND="sys-apps/sed"
RDEPEND="dev-lang/perl"
S=${WORKDIR}/${P}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
}

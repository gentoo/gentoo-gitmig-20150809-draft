# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devel-chroots/devel-chroots-1.0.0.ebuild,v 1.3 2005/02/19 12:59:30 dragonheart Exp $

DESCRIPTION="Gentoo Developer chroots installation/configuration launcher"
HOMEPAGE="http://www.gentoo.org"
# formally pappys

SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

# for testing purposes only
# KEYWORDS="-*"
# expected first scope, will be expanded to amd64 and/or ia64 when test machines available
KEYWORDS="~x86 ~sparc ~hppa"

IUSE=""

DEPEND="app-misc/screen net-misc/wget sys-apps/sed"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
}


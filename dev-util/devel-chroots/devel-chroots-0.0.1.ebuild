# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/devel-chroots/devel-chroots-0.0.1.ebuild,v 1.2 2004/08/14 02:34:03 pappy Exp $

DESCRIPTION="Gentoo Developer chroots installation/configuration launcher"
HOMEPAGE="http://dev.gentoo.org/~pappy"

SRC_URI=""
#SRC_URI="http://dev.gentoo.org/~pappy/dev/gentoo/gentoo-x86/dev-util/devel-chroots/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

# for testing purposes only
KEYWORDS="-*"
# expected first scope, will be expanded to amd64 and/or ia64 when test machines available
# KEYWORDS="~x86 ~sparc ~hppa"

IUSE="hardened static debug"

DEPEND="app-misc/screen net-misc/wget"

src_compile() {
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
}


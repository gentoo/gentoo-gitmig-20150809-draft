# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/pth/pth-2.0.2.ebuild,v 1.1 2004/11/30 06:18:59 dragonheart Exp $

DESCRIPTION="GNU Portable Threads"
HOMEPAGE="http://www.gnu.org/software/pth/"
SRC_URI="ftp://ftp.gnu.org/gnu/pth/pth-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~amd64 ~hppa ~ppc-macos"
IUSE=""

DEPEND="virtual/libc"

src_install() {
	einstall
	# emake D... broken
	# emake DESTDIR=${D} install || die
	dodoc ANNOUNCE AUTHORS ChangeLog NEWS README THANKS USERS
}

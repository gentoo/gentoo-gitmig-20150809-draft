# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/unscd/unscd-0.37.ebuild,v 1.1 2009/04/09 19:32:24 vapier Exp $

DESCRIPTION="simple & stable nscd replacement"
HOMEPAGE="http://busybox.net/~vda/unscd/README"
SRC_URI="http://busybox.net/~vda/unscd/nscd-${PV}.c"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""

S=${WORKDIR}

src_unpack() {
	cp "${DISTDIR}"/nscd-${PV}.c unscd.c || die
}

src_compile() {
	emake unscd || die
}

src_install() {
	into /
	dosbin unscd || die
}

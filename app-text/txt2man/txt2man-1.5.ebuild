# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/txt2man/txt2man-1.5.ebuild,v 1.1 2006/10/16 21:39:28 flameeyes Exp $

inherit eutils

DESCRIPTION="A simple script to convert ASCII text to man page."
HOMEPAGE="http://mvertes.free.fr/"
SRC_URI="http://mvertes.free.fr/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND="app-shells/bash
	sys-apps/gawk"
DEPEND="${RDEPEND}"

src_compile() {
	PATH="${S}:$PATH" make txt2man.1 || die "make failed"
}

src_install() {
	dobin txt2man
	doman txt2man.1

	dodoc README
}

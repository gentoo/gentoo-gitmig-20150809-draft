# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/queue-repair/queue-repair-0.9.0.ebuild,v 1.10 2006/10/21 19:44:13 hansmi Exp $

inherit eutils

DESCRIPTION="A toolkit for dealing with the qmail queue directory structure"
HOMEPAGE="http://pyropus.ca/software/queue-repair/"
SRC_URI="http://pyropus.ca/software/queue-repair/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha ~amd64 arm hppa ~ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

src_compile() {
	:
}

src_install () {
	insinto /usr/bin
	newbin queue_repair.py queue-repair.py || die
	dosym /usr/bin/queue-repair.py /usr/bin/queue-repair || die
	dodoc BLURB TODO CHANGELOG || die
}

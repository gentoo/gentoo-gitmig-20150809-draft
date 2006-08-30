# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/queue-repair/queue-repair-0.9.0.ebuild,v 1.4 2006/08/30 19:45:02 corsair Exp $

inherit eutils

DESCRIPTION="A toolkit for dealing with the qmail queue directory structure"
HOMEPAGE="http://pyropus.ca/software/queue-repair/"
SRC_URI="http://pyropus.ca/software/queue-repair/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="hppa mips ppc ~ppc64 sparc x86"
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

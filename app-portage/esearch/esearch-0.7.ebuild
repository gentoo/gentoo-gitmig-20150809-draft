# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/esearch/esearch-0.7.ebuild,v 1.6 2004/12/11 18:46:25 kloeri Exp $

DESCRIPTION="Replacement for 'emerge --search' with search-index"
HOMEPAGE="http://david-peter.de/esearch.html"
SRC_URI="http://david-peter.de/downloads/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~hppa ~mips ~arm amd64 ~ia64 ~ppc64 ~ppc-macos"
IUSE=""

RDEPEND=">=dev-lang/python-2.2
	>=sys-apps/portage-2.0.50"

src_install() {
	dodir /usr/bin/ /usr/sbin/

	exeinto /usr/lib/esearch
	doexe eupdatedb.py esearch.py esync.py common.py || die "doexe failed"

	dosym /usr/lib/esearch/esearch.py /usr/bin/esearch
	dosym /usr/lib/esearch/eupdatedb.py /usr/sbin/eupdatedb
	dosym /usr/lib/esearch/esync.py /usr/sbin/esync

	doman en/{esearch,eupdatedb,esync}.1
	dodoc ChangeLog "${FILESDIR}/eupdatedb.cron"

	if use linguas_it; then
		insinto /usr/share/man/it/man1
		doins it/{esearch,eupdatedb,esync}.1
	fi
}

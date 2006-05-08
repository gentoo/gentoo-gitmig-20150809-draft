# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mutagen/mutagen-1.1.ebuild,v 1.4 2006/05/08 04:08:31 tcort Exp $

inherit distutils

DESCRIPTION="Mutagen is an audio metadata tag reader and writer implemented in pure Python."
HOMEPAGE="http://www.sacredchao.net/quodlibet/wiki/Development/Mutagen"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

src_test() {
	# check for "FAIL" since _sanity.sh always returns the same value
	if sh _sanity.sh | grep -qs FAIL ; then
		sh _sanity.sh # display test results
		die "src_test failed."
	else
		einfo "All tests passed."
	fi
}

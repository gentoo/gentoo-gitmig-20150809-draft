# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/mutagen/mutagen-1.5.ebuild,v 1.1 2006/06/20 21:36:10 tcort Exp $

inherit distutils

DESCRIPTION="Mutagen is an audio metadata tag reader and writer implemented in pure Python."
HOMEPAGE="http://www.sacredchao.net/quodlibet/wiki/Development/Mutagen"
SRC_URI="http://www.sacredchao.net/~piman/software/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~x86"
IUSE=""

DEPEND=">=virtual/python-2.4"

src_test() {
	python setup.py test || die "src_test failed."
}

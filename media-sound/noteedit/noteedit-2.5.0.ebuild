# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/noteedit/noteedit-2.5.0.ebuild,v 1.1 2004/03/18 18:43:01 eradicator Exp $

inherit kde-functions kde

DESCRIPTION="Musical score editor (for Linux)."
HOMEPAGE="http://rnvs.informatik.tu-chemnitz.de/~jan/noteedit/"
SRC_URI="http://rnvs.informatik.tu-chemnitz.de/cgi-bin/nph-sendbin.cgi/~jan/${PN}/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="arts"

DEPEND="arts? ( kde-base/kdemultimedia )
	media-libs/tse3"

need-kde 3


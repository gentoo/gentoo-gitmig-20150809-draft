# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mkclean/mkclean-0.8.6.ebuild,v 1.1 2011/12/05 22:28:30 sbriesen Exp $

EAPI=4

inherit eutils

DESCRIPTION="mkclean is a command line tool to clean and optimize Matroska files"
HOMEPAGE="http://www.matroska.org/downloads/mkclean.html"
SRC_URI="http://downloads.sourceforge.net/project/matroska/${PN}/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_configure() {
	./configure  # non-standard configure

	# fixing generated makefiles
	sed -i -e 's|^\(LFLAGS.*+=.*\$(LIBS)\)|\1 \$(LDFLAGS)|g' \
		-e 's|^\(STRIP.*=\)|\1 echo|g' $(find -name "*.mak")
}

src_install() {
	dobin release/*/${PN}
	newdoc ChangeLog.txt ChangeLog
	newdoc ReadMe.txt README
}

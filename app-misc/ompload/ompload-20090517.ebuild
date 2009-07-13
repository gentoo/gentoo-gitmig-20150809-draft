# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ompload/ompload-20090517.ebuild,v 1.1 2009/07/13 06:09:53 omp Exp $

DESCRIPTION="CLI script for uploading files to http://omploader.org/"
HOMEPAGE="http://omploader.org/"
SRC_URI="http://omploader.org/${P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/ruby-1.8
	net-misc/curl"

S=${WORKDIR}

src_install() {
	newbin "${DISTDIR}/${P}" ${PN} || die "newbin failed"
}

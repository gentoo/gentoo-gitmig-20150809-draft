# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/profiler/profiler-1.ebuild,v 1.5 2004/06/24 21:35:14 agriffis Exp $

DESCRIPTION="provides 3D visual representation of file system statistics"
HOMEPAGE="http://visualversion.com/profiler/"
SRC_URI="http://visualversion.com/profiler/profiler.jar"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="x86"

RDEPEND="virtual/jre"

S=${WORKDIR}

src_unpack() {
	cp ${DISTDIR}/${A} ${S}/
}

src_install() {
	dobin ${FILESDIR}/profiler
	dojar ${A}
}

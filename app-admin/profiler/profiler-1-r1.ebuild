# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/profiler/profiler-1-r1.ebuild,v 1.6 2010/03/08 08:33:58 sping Exp $

inherit java-pkg-2

DESCRIPTION="Provides 3D visual representation of file system statistics"
HOMEPAGE="https://bugs.gentoo.org/show_bug.cgi?id=288717" # since visualversion.com died
SRC_URI="mirror://gentoo/profiler.jar"

LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc x86"

RDEPEND=">=virtual/jre-1.4"

S=${WORKDIR}

src_unpack() {

	cp "${DISTDIR}"/${A} "${S}"/

}

src_install() {

	dobin "${FILESDIR}"/profiler
	java-pkg_dojar ${A}

}

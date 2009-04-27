# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-archive/autoconf-archive-2009.04.26.ebuild,v 1.1 2009/04/27 03:40:52 vapier Exp $

inherit eutils

MY_PV=${PV//./-}
DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="http://autoconf-archive.cryp.to/"
SRC_URI="http://autoconf-archive.cryp.to/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

S=${WORKDIR}/${PN}-${MY_PV}

src_install() {
	emake install DESTDIR="${D}" || die
	dodir /usr/share/doc
	mv "${D}"/usr/share/{${PN},doc/${PF}} || die
}

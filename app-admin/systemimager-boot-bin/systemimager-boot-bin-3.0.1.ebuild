# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemimager-boot-bin/systemimager-boot-bin-3.0.1.ebuild,v 1.2 2004/05/31 19:21:33 vapier Exp $

MY_P="systemimager-i386boot-standard-3.0.1-4.noarch"

DESCRIPTION="System imager boot-i386. Software that automates Linux installs, software distribution, and production deployment."
HOMEPAGE="http://www.systemimager.org/"
SRC_URI="mirror://sourceforge/systemimager/${MY_P}.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-arch/rpm2targz"
RDEPEND="${DEPEND}
	app-admin/systemimager-server-bin"

S=${WORKDIR}

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm || die
	tar zxf ${WORKDIR}/${MY_P}.tar.gz || die
}

src_compile() {
	einfo "nothing to compile; binary package."
}

src_install() {
	insinto /usr/share/systemimager/boot/i386/standard
	doins usr/share/systemimager/boot/i386/standard/* || die
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/systemimager-common-bin/systemimager-common-bin-3.0.1.ebuild,v 1.6 2004/05/31 19:21:33 vapier Exp $

MY_P="systemimager-common-3.0.1-4.noarch"

DESCRIPTION="System imager common."
HOMEPAGE="http://www.systemimager.org/"
SRC_URI="mirror://sourceforge/systemimager/${MY_P}.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="app-arch/rpm2targz"
RDEPEND="${DEPEND}
	app-admin/systemconfigurator"

S=${WORKDIR}

src_unpack() {
	rpm2targz ${DISTDIR}/${MY_P}.rpm || die
	tar zxf ${WORKDIR}/${MY_P}.tar.gz || die
}

src_compile() {
	einfo "nothing to compile; binary package."
}

src_install() {
	dobin usr/bin/lsimage || die
	insinto /usr/lib/systemimager/perl/SystemImager/
	doins usr/lib/systemimager/perl/SystemImager/{Common,Config}.pm || die
	doman usr/share/man/man5/autoinstallscript.conf.5.gz
	doman usr/share/man/man8/lsimage.8.gz
}

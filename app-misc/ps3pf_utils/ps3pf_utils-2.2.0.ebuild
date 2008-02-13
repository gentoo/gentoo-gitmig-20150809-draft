# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/ps3pf_utils/ps3pf_utils-2.2.0.ebuild,v 1.1 2008/02/13 01:54:32 ranger Exp $

inherit flag-o-matic

DESCRIPTION="Utilities to set the ps3 specific features"
HOMEPAGE="http://www.playstation.com/ps3-openplatform/index.html"
SRC_URI="http://www.kernel.org/pub/linux/kernel/people/geoff/cell/ps3-utils/ps3-utils-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-ppc -ppc64"
IUSE=""

# fixme: depend on a version of sys-kernel/linux-headers that supports ps3

DEPEND=""
RDEPEND=""

S=${WORKDIR}/ps3-utils-${PV}/
src_compile() {
	econf || die "Could not configure"
	emake || die "compile failed, do you have up to date kernel sources?"
}

src_install() {
	emake DESTDIR=${D} install || die "install failed"
}

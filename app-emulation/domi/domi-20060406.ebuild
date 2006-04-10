# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/domi/domi-20060406.ebuild,v 1.1 2006/04/10 07:52:06 chrb Exp $

inherit eutils
DESCRIPTION="Scripts for building Xen domains"
HOMEPAGE="http://www.bytesex.org"
EXTRA_VERSION="104418"
SRC_URI="http://dl.bytesex.org/cvs-snapshots/${P}-${EXTRA_VERSION}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="app-emulation/xen-tools"
S=${WORKDIR}/${PN}

src_install() {
	einstall || die
	insinto /etc
	doins ${FILESDIR}/domi.conf || die
}

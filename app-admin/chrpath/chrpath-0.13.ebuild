# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/chrpath/chrpath-0.13.ebuild,v 1.10 2008/11/23 18:05:16 patrick Exp $

inherit eutils

DESCRIPTION="chrpath can modify the rpath and runpath of ELF executables"
HOMEPAGE="http://directory.fsf.org/project/chrpath/"
SRC_URI="ftp://ftp.hungry.com/pub/hungry/chrpath/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc x86 ~x86-fbsd"
IUSE=""

src_install() {
	dobin chrpath || die
	doman chrpath.1
	dodoc ChangeLog AUTHORS NEWS README
}

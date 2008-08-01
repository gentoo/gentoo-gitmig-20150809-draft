# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/radare/radare-0.9.9.ebuild,v 1.2 2008/08/01 04:19:56 mr_bones_ Exp $

DESCRIPTION="Advanced command line hexadecimail editor and more"
HOMEPAGE="http://radare.nopcode.org"
SRC_URI="http://radare.nopcode.org/get/radare-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="sys-libs/readline
		dev-lang/python
		"
RDEPEND="${DEPEND}"

src_install() {
	emake ROOT="${D}" DESTDIR="${D}" install || die "install failed"
}

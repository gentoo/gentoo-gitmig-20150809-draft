# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/kid/kid-0.7.1.ebuild,v 1.1 2005/11/10 23:32:10 pythonhead Exp $

inherit distutils

DESCRIPTION="A simple and Pythonic XML template language"
SRC_URI="http://kid.lesscode.org/dist/${PV}/${P}.tar.gz"
HOMEPAGE="http://kid.lesscode.org/"

KEYWORDS="~x86"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/elementtree-1.2.6"


src_unpack() {
	unpack ${A}
	cd ${S} || die "Failed to unpack ${A}"
	#Use distutils instead of egg
	epatch ${FILESDIR}/${P}-ezsetup-gentoo.patch
}

pkg_postinst() {
	einfo "Installing dev-python/celementree may enhance performance."
}


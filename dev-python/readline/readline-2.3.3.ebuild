# Copyright 1999-2004 Gentoo Foundation, Pieter Van den Abeele <pvdabeel@gentoo.org>
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/readline/readline-2.3.3.ebuild,v 1.2 2004/07/19 12:35:36 usata Exp $

DESCRIPTION="Readline Python module, extends default Darwin Python with readline support"

HOMEPAGE="http://www.opensource.apple.com/darwinsource/"
SRC_URI="http://www.metadistribution.org/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* macos"
IUSE=""

DEPEND=">=sys-libs/readline-4.3
	>=dev-lang/python-2.3.3"

src_install() {
	python ./setup.py install --root=${D} || die
}

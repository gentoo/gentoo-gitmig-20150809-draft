# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/syck/syck-0.25.ebuild,v 1.1 2003/05/08 09:54:31 twp Exp $

DESCRIPTION="An extension for reading YAML swiftly in popular scripting languages"
HOMEPAGE="http://www.whytheluckystiff.net/syck/"
SRC_URI="mirror://sourceforge/yaml4r/${P}.tar.gz"
LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86"
DEPEND="virtual/glibc"

src_compile() {
	econf || die
	emake
}

src_install() {
	einstall || die
	dodoc README
}

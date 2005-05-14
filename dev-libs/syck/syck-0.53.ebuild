# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/syck/syck-0.53.ebuild,v 1.1 2005/05/14 16:59:49 mcummings Exp $

IUSE=""
DESCRIPTION="Syck is an extension for reading and writing YAML swiftly in popular scripting languages."
HOMEPAGE="http://whytheluckystiff.net/syck/"
SRC_URI="http://rubyforge.org/frs/download.php/3717/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86"
DEPEND=" sys-libs/glibc "

src_compile() {
	econf
	emake
}

src_install() {
	einstall
}

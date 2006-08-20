# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/syck/syck-0.55.ebuild,v 1.2 2006/08/20 17:58:09 yuval Exp $

inherit flag-o-matic

IUSE=""
DESCRIPTION="Syck is an extension for reading and writing YAML swiftly in popular scripting languages."
HOMEPAGE="http://whytheluckystiff.net/syck/"
SRC_URI="http://rubyforge.org/frs/download.php/4492/${P}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=" sys-libs/glibc "

src_compile() {
	append-flags -fPIC
	econf
	emake
}

src_install() {
	einstall
}

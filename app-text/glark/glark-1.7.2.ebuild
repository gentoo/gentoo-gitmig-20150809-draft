# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/glark/glark-1.7.2.ebuild,v 1.4 2005/03/31 20:59:11 blubb Exp $

inherit bash-completion

DESCRIPTION="File searcher similar to grep but with fancy output"
HOMEPAGE="http://glark.sourceforge.net/"
SRC_URI="mirror://sourceforge/glark/${P}.tar.gz"

KEYWORDS="x86 sparc ~ppc mips amd64 ~hppa"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

# perl dep is for pod2man
DEPEND="virtual/ruby
	dev-lang/perl"
RDEPEND="virtual/ruby"

src_compile() {
	emake
	# force the manpage to be rebuilt
	rm ${PN}.1
	make ${PN}.1
}

src_install () {
	make DESTDIR=${D} install
	dobashcompletion ${FILESDIR}/${PV}/glark-completion ${PN}
}


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-3.1.0.ebuild,v 1.2 2003/10/22 15:57:49 cretin Exp $

DESCRIPTION="Beecrypt is a general-purpose cryptography library."
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="python"
DEPEND="python? ( =dev-lang/python-2.2* )"
S=${WORKDIR}/${P}

src_compile() {
	local myconf
	use python && myconf="--with-python"
	econf --enable-shared --enable-static $myconf || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die

	# Not needed
	rm -f ${D}/usr/lib/python*/site-packages/_bc.*a

	dodoc BUGS README BENCHMARKS ChangeLog NEWS
}

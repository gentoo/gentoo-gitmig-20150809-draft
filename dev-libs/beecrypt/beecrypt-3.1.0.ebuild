# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-3.1.0.ebuild,v 1.1 2003/10/21 16:38:30 cretin Exp $

DESCRIPTION="Beecrypt is a general-purpose cryptography library."
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE="python doc"
DEPEND="python? ( =dev-lang/python-2.2* )
	doc? ( app-doc/doxygen )"
S=${WORKDIR}/${P}

src_compile() {
	local myconf
	use python && myconf="--with-python"
	econf --enable-shared --enable-static $myconf || die
	emake || die
	if [ -n "`use doc`" ] ; then
		doxygen || die
	fi
}

src_install() {
	make install DESTDIR=${D} || die

	if [ -n "`use doc`" ] ; then
		dohtml docs/html/*
	fi

	# Not needed
	rm -f ${D}/usr/lib/python*/site-packages/_bc.*a

	dodoc BUGS README BENCHMARKS ChangeLog NEWS
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/hermes/hermes-1.3.2-r2.ebuild,v 1.14 2004/02/08 01:53:50 vapier Exp $

inherit gnuconfig

MY_P=${P/h/H}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Library for fast colorspace conversion and other graphics routines"
HOMEPAGE="http://hermes.terminal.at/"
SRC_URI="http://dark.x.dtu.dk/~mbn/clanlib/download/download-sphair/${MY_P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha ~mips amd64"

DEPEND="sys-devel/libtool
	sys-devel/automake
	sys-devel/autoconf"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	use alpha && gnuconfig_update
	use amd64 && gnuconfig_update
	aclocal || die "aclocal failed"
	env WANT_AUTOMAKE=1.4 automake -a || die "automake failed"
	autoconf || die "autoconf failed"
}

src_compile() {
	econf || die
	sh ltconfig ltmain.sh || die "ltconfig failed"
	emake || die "make failed"
}

src_install() {
	make \
		prefix=${D}/usr \
		install || die

	dodoc AUTHORS COPYING ChangeLog FAQ NEWS README TODO*

	dohtml docs/api/*.htm
	docinto print
	dodoc docs/api/*.ps
	docinto txt
	dodoc docs/api/*.txt
	docinto sgml
	dodoc docs/api/sgml/*.sgml
}

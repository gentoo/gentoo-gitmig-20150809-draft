# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/eet/eet-0.0.1.20030629.ebuild,v 1.1 2003/06/29 17:44:11 vapier Exp $

inherit enlightenment flag-o-matic

DESCRIPTION="E file chunk reading/writing library"
HOMEPAGE="http://www.enlightenment.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
	http://wh0rd.tk/gentoo/distfiles/${P}.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~alpha ~ppc"

S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${A}
	gettext_modify
}

src_compile() {
	env PATH="${T}:${PATH}" WANT_AUTOCONF_2_5=1 NOCONFIGURE=yes ./autogen.sh || die
	[ `use alpha` ] || [ `use ppc` ] && append-flags -fPIC
	econf --with-gnu-ld || die
	emake || die
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog Doxyfile NEWS README
	dohtml -r doc
}

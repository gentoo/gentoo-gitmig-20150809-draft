# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-mud/mcl/mcl-0.52.99.ebuild,v 1.2 2004/02/20 06:45:14 mr_bones_ Exp $

IUSE="python perl"

S="${WORKDIR}/${P}"
DESCRIPTION="A console MUD client scriptable in Perl and Python"
SRC_URI="http://www.andreasen.org/mcl/dist/${P}-src.tar.gz"
HOMEPAGE="http://www.andreasen.org/mcl/"
LICENSE="GPL-2"
DEPEND="perl? ( dev-lang/perl )
	python? ( dev-lang/python )"

KEYWORDS="x86"
SLOT="0"

src_compile() {
	local myconf
	use perl	&& myconf="${myconf} --enable-perl"	|| myconf="${myconf} --disable-perl"
	use python	&& myconf="${myconf} --enable-python"	|| myconf="${myconf} --disable-python"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man $myconf || die "./configure failed"

	patch -p0<${FILESDIR}/mcl-0.52.99-gcc3.patch

	emake || die
}

src_install () {
	make INSTALL_ROOT=${D} install || die

	dodoc doc/*
}

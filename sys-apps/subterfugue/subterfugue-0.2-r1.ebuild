# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/subterfugue/subterfugue-0.2-r1.ebuild,v 1.15 2003/06/21 21:19:41 drobbins Exp $

IUSE="gtk"

S=${WORKDIR}/${P}
DESCRIPTION="strace meets expect"
SRC_URI="mirror://sourceforge/subterfugue/${P}.tgz"
HOMEPAGE="http://www.subterfugue.org/"
KEYWORDS="x86 amd64 -ppc"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=dev-lang/python-2.0
	gtk? ( =x11-libs/gtk+-1.2* )"

src_unpack() {
	PYVER=$(python -V 2>&1 | sed -e 's:Python \([0-9].[0-9]\).*:\1:')

	unpack ${A}

	cd ${S}
    
	cp Makefile Makefile.orig
	sed "s/python1.5/python${PYVER}/" < Makefile.orig > Makefile
}

src_compile() {
	# breaks down with emake
	make || die
    
	cp dsf dsf.orig
	sed -e "s:SUBTERFUGUE_ROOT=.*:SUBTERFUGUE_ROOT=/usr/share/subterfuge/:" \
		< dsf.orig > sf
}

src_install() {
	into /usr

	dobin sf

	dodoc COPYING CREDITS GNU-entry INSTALL INTERNALS NEWS README TODO

	doman doc/sf.1

	SH=/usr/share/subterfuge

	exeinto ${SH}
	doexe *.{py,pyc}

	exeinto ${SH}/tricks
	doexe tricks/*.{py,pyc}

	exeinto ${SH}/modules
	doexe modules/*.so
}

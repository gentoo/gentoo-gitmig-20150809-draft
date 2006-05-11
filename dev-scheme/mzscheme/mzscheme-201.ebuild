# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-scheme/mzscheme/mzscheme-201.ebuild,v 1.1 2006/05/11 21:50:11 mkennedy Exp $

S=${WORKDIR}/plt
DESCRIPTION="MzScheme scheme compiler"
HOMEPAGE="http://www.plt-scheme.org/software/mzscheme/"
SRC_URI="ftp://ftp.ibiblio.org/pub/Linux/distributions/gentoo/distfiles/mzscheme.src.unix-201.tar.gz"
DEPEND=">=sys-devel/gcc-2.95.3-r7"
#RDEPEND=""
SLOT="0"
LICENSE="LGPL-2.1"
KEYWORDS="x86 ppc"
IUSE=""

src_compile() {
	cd ${S}/src

	econf \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"

	make || die
}

src_install () {
	cd ${S}/src
	echo -e "n\n" | make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die
	cd ${S}
	dodoc README
	dodoc notes/COPYING.LIB
	dodoc notes/mzscheme/*

	# 2002-09-06: karltk
	# Normally, one specifies the full path to the collects,
	# so this should work, but it's not been tested properly.
	mv ${D}/usr/install ${D}/usr/bin/mzscheme-install

	dodir /usr/share/mzscheme
	mv ${D}/usr/collects/ ${D}/usr/share/mzscheme/collects/

	rm -rf ${D}/usr/notes/
}

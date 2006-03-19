# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/plt/plt-202.ebuild,v 1.14 2006/03/19 23:19:07 joshuabaergen Exp $

inherit eutils

DESCRIPTION="PLT Scheme, including DrScheme, mzscheme, mred, and mzc"
HOMEPAGE="http://www.plt-scheme.org/software/drscheme/"
SRC_URI="http://www.cs.utah.edu/plt/download/${PV}/plt/plt.src.x.tar.gz"

KEYWORDS="x86"
SLOT="0"
LICENSE="LGPL-2.1"
IUSE=""

DEPEND="virtual/libc
	|| ( x11-libs/libXaw virtual/x11 )
	sys-devel/gcc
	sys-devel/binutils"

S=${WORKDIR}/${PN}/src

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gcc3.3.patch
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--with-x \
		--enable-mred \
		--prefix=${D}/usr/share/plt || die "./configure failed"
	make || die
}

src_install() {
	dodir usr/share/plt
	make copytree || die
	make mzinstall || die
	make mrinstall || die
	make lib-finish || die

	dodir usr/bin

	# compile scheme sources to make startup quicker
	/usr/bin/env PLTHOME=${D}/usr/share/plt \
		${D}/usr/share/plt/bin/setup-plt || die

	# move man files to correct location and delete
	# them out of plt tree
	doman ${D}/usr/share/plt/man/man1/*
	rm -r ${D}/usr/share/plt/man

	# move misc package documentation to proper location
	# and delete them out of plt tree
	dodoc ${D}/usr/share/plt/notes/COPYING.LIB \
		${D}/usr/share/plt/notes/mzscheme/*
	rm -r ${D}/usr/share/plt/notes

	# create executable scripts in /usr/bin which in turn call
	# executables by the same name in /usr/share/plt with the
	# correct PLTHOME path
	for f in mzc tex2page help-desk mred mzscheme drscheme setup-plt ; do
		target=${D}/usr/bin/$f
		echo '#! /bin/sh'> $target
		echo 'PLTHOME=/usr/share/plt ; export PLTHOME'>> $target
		echo 'exec ${PLTHOME}/bin/'$f' "$@"' >> $target
		chmod 755 $target
	done
}

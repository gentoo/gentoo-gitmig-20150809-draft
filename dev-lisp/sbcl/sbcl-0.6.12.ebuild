# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/sbcl/sbcl-0.6.12.ebuild,v 1.13 2003/09/06 22:35:54 msterret Exp $

DESCRIPTION="SteelBank Common Lisp"
HOMEPAGE="http://sbcl.sourceforge.net/"
SRC_URI="mirror://sourceforge/sbcl/${P}-source.tar.bz2
	mirror://sourceforge/sbcl/${P}-linux-binary.tar.bz2"

LICENSE="MIT"
SLOT="0"
KEYWORDS="x86"

PROVIDE="virtual/commonlisp"

src_unpack() {
	unpack ${P}-linux-binary.tar.bz2 ; mv ${P} ${P}-binary
	unpack ${P}-source.tar.bz2
}

src_compile() {
	export SBCL_HOME="../${P}-binary/output/"
	export GNUMAKE="make"
	sh make.sh "../${P}-binary/src/runtime/sbcl" || die "sh make.sh failed"

	if which jade > /dev/null ; then
		cd doc
		sh make-doc.sh || die "sh make-doc.sh failed"
	else
		echo "Jade missing: Not building documentation"
	fi
}

src_install() {
	doman doc/sbcl.1
	dobin src/runtime/sbcl

	dodoc BUGS CREDITS NEWS README INSTALL COPYING

	insinto /usr/share/sbcl
	doins output/sbcl.core
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icon/icon-9.40.ebuild,v 1.20 2006/04/29 00:50:59 halcy0n Exp $

MY_PV=${PV/./}
SRC_URI="http://www.cs.arizona.edu/icon/ftp/packages/unix/icon.v${MY_PV}src.tgz"
HOMEPAGE="http://www.cs.arizona.edu/icon/"
DESCRIPTION="very high level language"

LICENSE="as-is"
SLOT="0"
KEYWORDS="-x86"
IUSE="X"

S=${WORKDIR}/icon.v${MY_PV}src

DEPEND="X? ( || (
		( x11-libs/libX11 x11-libs/libXpm )
	virtual/x11 ) )
	sys-devel/gcc"

src_unpack() {
	unpack ${A}
	cd ${S}/config/unix/intel_linux
	patch -p0 <${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	if use X; then
		make X-Configure name=intel_linux || die
	else
		make Configure name=intel_linux || die
	fi

	make || die

	# small builtin test
	make Samples || die
	# large builtin test
	make Test || die
}

src_install() {
	#make Install dest=${D}/opt/icon || die
	# fhs-problems, manual rectify
	into /usr

	cd ${S}/bin
	rm .placeholder libXpm.a rt.h
	dobin *

	cd ${S}/lib
	rm .placeholder
	dolib *

	cd ${S}/man/man1
	doman icont.1

	cd ${S}/doc
	dodoc * ../README
}

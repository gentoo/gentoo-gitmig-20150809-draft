# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icon/icon-9.4.2.ebuild,v 1.1 2004/07/31 01:20:54 george Exp $

MY_PV=${PV//./}
SRC_URI="http://www.cs.arizona.edu/icon/ftp/packages/unix/icon.v${MY_PV}src.tgz"
HOMEPAGE="http://www.cs.arizona.edu/icon/"
DESCRIPTION="very high level language"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="X"

S=${WORKDIR}/icon.v${MY_PV}src

DEPEND="X? ( virtual/x11 )
	sys-devel/gcc"

src_unpack() {
	unpack ${A}
	cd ${S}/config
	#this is just a nicefier, so no || die ..
	grep -rle "CFLAGS = -O2" . | xargs sed -i -e "s:CFLAGS = -O2:CFLAGS = ${CFLAGS}:"
}

src_compile() {
	if use X; then
		emake X-Configure name=linux -j1 || die
	else
		emake Configure name=linux -j1 || die
	fi

	emake -j1 || die

	# small builtin test
	#make Samples || die
	# large builtin test
	#make Test || die
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

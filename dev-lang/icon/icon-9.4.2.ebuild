# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icon/icon-9.4.2.ebuild,v 1.4 2006/03/16 14:02:08 caleb Exp $

MY_PV=${PV//./}
SRC_URI="http://www.cs.arizona.edu/icon/ftp/packages/unix/icon.v${MY_PV}src.tgz"
HOMEPAGE="http://www.cs.arizona.edu/icon/"
DESCRIPTION="very high level language"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc-macos ~x86"
IUSE="X"

S=${WORKDIR}/icon.v${MY_PV}src

DEPEND="X? ( || (
		( x11-libs/libX11 x11-libs/libXpm )
	virtual/x11 ) )
	sys-devel/gcc"

src_unpack() {
	unpack ${A}
	cd ${S}/config
	#this is just a nicefier, so no || die ..
	grep -rle "CFLAGS = -O2" . | xargs sed -i -e "s:CFLAGS = -O2:CFLAGS = ${CFLAGS}:"
}

src_compile() {
	# select the right compile target.  Note there are many platforms
	# available
	local mytarget;
	if use ppc-macos;
	then
		mytarget="ppc_macos"
	else
		mytarget="linux"
	fi

	if use X; then
		emake X-Configure name=${mytarget} -j1 || die
	else
		emake Configure name=${mytarget} -j1 || die
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

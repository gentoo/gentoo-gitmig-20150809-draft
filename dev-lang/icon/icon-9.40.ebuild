# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-lang/icon/icon-9.40.ebuild,v 1.7 2002/08/14 11:58:50 murphy Exp $

S=${WORKDIR}/icon.v940src
SRC_URI="http://www.cs.arizona.edu/icon/ftp/packages/unix/icon.v940src.tgz"

HOMEPAGE="http://www.cs.arizona.edu/icon/"
DESCRIPTION="icon is a v. high level language"

DEPEND="X? ( virtual/x11 )
	sys-devel/gcc"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 sparc sparc64"

src_unpack() {
	
	cd ${WORKDIR}
	unpack ${A}
	cd ${S}/config/unix/intel_linux
	patch -p0 <${FILESDIR}/${P}-gentoo.diff
	
}

src_compile() {
	
	cd ${S}

	if [ "`use X`" ]; then
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

src_install () {
	
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

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tla/tla-20040113.ebuild,v 1.1 2004/01/15 19:58:17 rphillips Exp $

MY_P="${P/-/_}"

S="${WORKDIR}/tla.lord/src/=build"
DESCRIPTION="Revision control system ideal for widely distributed development"
# http://arch.quackerhead.com/~lord/releases/tla/${MY_P}.tar.gz
SRC_URI="http://gluck.debian.org/~asuffield/arch/${MY_P}.orig.tar.gz"
HOMEPAGE="http://arch.quackerhead.com/~lord/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~alpha ~ppc ~mips ~hppa ~sparc ~arm"

DEPEND="sys-apps/coreutils
	sys-apps/diffutils
	sys-devel/patch
	sys-apps/findutils
	sys-apps/gawk
	app-arch/tar
	sys-apps/util-linux
	sys-apps/debianutils
	sys-devel/make"

src_unpack() {
	unpack "${A}"
	mkdir "tla.lord/src/=build"
}

src_compile() {
	../configure \
		--prefix="/usr" \
		--with-posix-shell="/bin/bash"	|| die "configure failed"
	# parallel make may cause problems with this package
	make || die "make failed"
}

src_install () {
	make install prefix="${D}/usr" \
		|| die "make install failed"
	cd ${WORKDIR}/${MY_P}/src
	dodoc COPYING
	cd docs-tla
	dodoc =README
	cd html
	dohtml -r .
}

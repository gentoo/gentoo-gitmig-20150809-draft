# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/tla/tla-1.2.1_pre1.ebuild,v 1.4 2004/07/15 00:13:08 agriffis Exp $

MY_P="${P/_/}"

S="${WORKDIR}/${MY_P}/src/=build"
DESCRIPTION="Revision control system ideal for widely distributed development"
SRC_URI="http://release.gnuarch.org/${MY_P}.tar.gz"
HOMEPAGE="http://arch.quackerhead.com/~lord/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha ppc hppa sparc ~amd64"
IUSE=""

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
	mkdir "${MY_P}/src/=build"
}

src_compile() {
	sed -i 's:/home/lord/{install}:/usr:g' "${WORKDIR}/${MY_P}/src/tla/=gpg-check.awk"
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
	docinto ps
	dodoc ps/*.ps
	docinto html
	dohtml -r html/

	chmod 755 "${WORKDIR}/${MY_P}/src/tla/=gpg-check.awk"
	cp -a "${WORKDIR}/${MY_P}/src/tla/=gpg-check.awk" "${D}/usr/bin/tla-gpg-check.awk"
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bazaar/bazaar-1.1.1.ebuild,v 1.1 2005/01/23 00:20:15 arj Exp $

S="${WORKDIR}/${P}/src/=build"
DESCRIPTION="Bazaar is a user-interface branch of tla"
SRC_URI="http://bazaar.canonical.com/releases/src/bazaar_${PV}.tar.gz"
HOMEPAGE="http://bazaar.canonical.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64"
IUSE=""

DIR="thelove@canonical.com---dists--bazaar--1.1"

DEPEND="sys-apps/coreutils
	sys-apps/diffutils
	sys-devel/patch
	sys-apps/findutils
	sys-apps/gawk
	app-arch/tar
	sys-apps/util-linux
	sys-apps/debianutils
	sys-devel/make
	>=net-misc/neon-0.24.7"

src_unpack() {
	unpack "${A}"
	mv ${DIR} ${P}
	mkdir "${P}/src/=build"
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

	cd ${WORKDIR}/${P}/
	dodoc =ARCH-USERS-README
	cd ${WORKDIR}/${P}/src
	dodoc COPYING
	cd docs-baz
	dodoc =README
	docinto ps
	dodoc ps/*.ps
	docinto html
	dohtml -r html/
}

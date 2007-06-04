# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bazaar/bazaar-1.3.2.ebuild,v 1.5 2007/06/04 23:07:51 marienz Exp $

inherit eutils

S="${WORKDIR}/${P}/src/=build"
DESCRIPTION="Bazaar is a user-interface branch of tla (GNU Arch)."
SRC_URI="http://bazaar.canonical.com/releases/src/bazaar_${PV}.tar.gz
	http://dev.gentoo.org/~arj/baz.1.gz"
HOMEPAGE="http://bazaar-vcs.org/Baz1x"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ppc"
IUSE=""

DIR="thelove@canonical.com---dists--bazaar--1.3"

DEPEND="sys-apps/coreutils
	sys-apps/diffutils
	sys-devel/patch
	sys-apps/findutils
	sys-apps/gawk
	app-arch/tar
	sys-apps/util-linux
	sys-apps/debianutils
	sys-devel/make
	>=net-misc/neon-0.24.7
	>=app-crypt/gpgme-1.0.2"

src_unpack() {
	unpack bazaar_${PV}.tar.gz
	unpack baz.1.gz
	mv ${DIR} ${P}
	mkdir "${P}/src/=build"
	cd ${P}

	# baz annotate does the same thing as this binary
	rm -rf src/baz/annotate

	epatch ${FILESDIR}/baz-gpgme-fix.patch
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
	dodoc baz/=THANKS
	cd ${WORKDIR}
	doman baz.1
}

pkg_postinst() {
	einfo 'This package installs the "baz" utility. If you are looking for'
	einfo 'the "bzr" utility, use "emerge bzr".'
}

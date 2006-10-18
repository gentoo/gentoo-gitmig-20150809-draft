# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/bazaar/bazaar-1.4.2-r1.ebuild,v 1.2 2006/10/18 04:29:20 tsunam Exp $

inherit eutils

S="${WORKDIR}/${P}/src/=build"
DESCRIPTION="Bazaar is a user-interface branch of tla"
SRC_URI="http://bazaar.canonical.com/releases/src/bazaar_${PV}.tar.gz
	http://dev.gentoo.org/~arj/baz.1.4.gz"
HOMEPAGE="http://bazaar.canonical.com/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

DIR="thelove@canonical.com---dists--bazaar--1.4"

DEPEND="sys-apps/coreutils
	sys-apps/diffutils
	sys-devel/patch
	sys-apps/findutils
	sys-apps/gawk
	app-arch/tar
	sys-apps/util-linux
	sys-apps/debianutils
	sys-devel/make
	>=net-misc/neon-0.26.1
	>=app-crypt/gpgme-1.0.2"

src_unpack() {
	unpack bazaar_${PV}.tar.gz
	unpack baz.1.4.gz
	mv ${DIR} ${P}
	mkdir "${P}/src/=build"
	cd ${P}

	# baz annotate does the same thing as this binary
	rm -rf src/baz/annotate

	epatch ${FILESDIR}/baz-gpgme-fix.patch
	epatch ${FILESDIR}/neon-0.24-fix.patch
	epatch ${FILESDIR}/neon-0.26-fix.patch
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

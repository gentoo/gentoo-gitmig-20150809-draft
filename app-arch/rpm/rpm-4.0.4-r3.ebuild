# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.0.4-r3.ebuild,v 1.6 2002/09/21 22:20:22 vapier Exp $

# note to self: check for java deps

S=${WORKDIR}/${P}
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc sparc64 alpha"

RDEPEND="=sys-libs/db-3.2*
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1
	>=dev-libs/popt-1.6.3"

DEPEND="${RDEPEND}
	sys-devel/gettext"

src_unpack() {

	export WANT_AUTOCONF_2_1=1

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-system-popt.diff || die
	rm -rf ${S}/popt
	# Suppress pointer warnings
	cp configure configure.orig
	sed -e "s:-Wpointer-arith::" configure.orig > configure
}

src_compile() {

	local myconf
	use nls || myconf="--disable-nls"
	use sparc64 && myconf="$myconf --host=${CHOST}"

	econf ${myconf} || die
	make || die
}

src_install() {

	make DESTDIR=${D} install || die
	mv ${D}/bin/rpm ${D}/usr/bin
	rm -rf ${D}/bin

	dodoc CHANGES COPYING CREDITS GROUPS README* RPM* TODO
}

pkg_postinst() {

	${ROOT}/usr/bin/rpm --initdb --root=${ROOT}
}

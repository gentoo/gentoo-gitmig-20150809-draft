# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.0.4-r5.ebuild,v 1.2 2003/03/06 18:38:17 cretin Exp $

inherit flag-o-matic

# note to self: check for java deps
DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.0.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org/"

SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="x86 ppc sparc alpha"
IUSE="nls"

RDEPEND="=sys-libs/db-3.2*
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1
	>=dev-libs/popt-1.6.3"

DEPEND="${RDEPEND}
	sys-devel/gettext"

filter-flags -fPIC

src_unpack() {
	export WANT_AUTOCONF_2_1=1

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${P}-system-popt.diff || die
	patch -p1 < ${FILESDIR}/${P}-glibc2.3.diff || die
	rm -rf ${S}/popt
	# Suppress pointer warnings
	cp configure configure.orig
	sed -e "s:-Wpointer-arith::" configure.orig > configure
}

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"
	econf ${myconf}
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	mv ${D}/bin/rpm ${D}/usr/bin
	rm -rf ${D}/bin

	# Fix for bug #8578 (app-arch/rpm create dead symlink)
	# Local RH 7.3 install has no such symlink anywhere
	rm -f ${D}/usr/lib/rpmpopt

	keepdir /var/lib/rpm

	dodoc CHANGES COPYING CREDITS GROUPS README* RPM* TODO
}

pkg_postinst() {
	if [ -f ${ROOT}/var/lib/rpm/nameindex.rpm ]; then
		einfo "RPM database found... Rebuilding database (may take a while)..."
		${ROOT}/usr/bin/rpm --rebuilddb --root=${ROOT}
	else
		einfo "No RPM database found... Creating database..."
		${ROOT}/usr/bin/rpm --initdb --root=${ROOT}
	fi
}

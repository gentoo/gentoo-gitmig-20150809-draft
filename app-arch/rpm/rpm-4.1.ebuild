# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/rpm/rpm-4.1.ebuild,v 1.1 2003/02/19 21:09:23 raker Exp $

# It builds.  It just doesn't run.  gdb and strace leave me with
# inconclusive answers.  Bueller?  Anybody?  - raker 02/19/2003

inherit flag-o-matic eutils libtool

DESCRIPTION="Red Hat Package Management Utils"
SRC_URI="ftp://ftp.rpm.org/pub/rpm/dist/rpm-4.1.x/${P}.tar.gz"
HOMEPAGE="http://www.rpm.org/"
SLOT="0"
LICENSE="GPL-2 LGPL-2"
KEYWORDS="-x86 -ppc -sparc -alpha"
IUSE="nls python doc static"
RDEPEND="=sys-libs/db-3.2*
	>=sys-libs/zlib-1.1.3
	>=sys-apps/bzip2-1.0.1
	>=dev-libs/popt-1.7
	>=app-crypt/gnupg-1.2
	nls? ( sys-devel/gettext )
	python? ( =dev-lang/python-2.2* )
	doc? ( app-doc/doxygen )"

filter-flags -fPIC

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-system-popt.diff
}

src_compile() {
	local myconf
	myconf="--without-included-gettext --with-gnu-ld"
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	use python \
		&& myconf="${myconf} --with-python" \
		|| myconf="${myconf} --without-python"
	use doc \
		&& myconf="${myconf} --with-apidocs" \
		|| myconf="${myconf} --without-apidocs"
	use static \
		&& myconf="${myconf} --enable-static" \
		|| myconf="${myconf} --disable-static"
	if [ ! -z $DEBUGBUILD ]; then
		myconf="${myconf} --with-dmalloc --with-efence"
	else
		myconf="${myconf} --without-dmalloc --without-efence"
	fi
	use python && export CPPFLAGS="-I/usr/include/python2.2"
	econf ${myconf}
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
	mv ${D}/bin/rpm ${D}/usr/bin
	rm -rf ${D}/bin
	# Fix for bug #8578 (app-arch/rpm create dead symlink)
	# Local RH 7.3 install has no such symlink anywhere
	# ------
	# UPDATE for 4.1!
	# There is a /usr/lib/rpm/rpmpopt-4.1 now
	# the symlink is still created incorrectly. ???
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

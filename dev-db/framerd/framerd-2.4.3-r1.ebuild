# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/framerd/framerd-2.4.3-r1.ebuild,v 1.13 2005/01/09 12:10:37 swegener Exp $

DESCRIPTION="FramerD is a portable distributed object-oriented database designed to support the maintenance and sharing of knowledge bases."
HOMEPAGE="http://www.framerd.org/"
SRC_URI="mirror://sourceforge/framerd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="readline"

DEPEND="virtual/libc
	readline? ( >=sys-libs/readline-4.1-r4 )"

src_compile() {
	patch -p0 ${S}/etc/setup.fdx ${FILESDIR}/setup.fdx.patch
	MY_OPTS="--enable-shared"
	if ! use readline; then
		MY_OPTS="${MY_OPTS} --without-readline"
	fi
	econf ${MY_OPTS} || die "econf failed"

	emake || die "make failed"
	#emake test || die "make test failed" # failed!!
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	mv ${D}/usr/share/framerd/framerd.cfg ${D}/usr/share/framerd/framerd.cfg_orig
	perl -pe "s|${D}||" ${D}/usr/share/framerd/framerd.cfg_orig > ${D}/usr/share/framerd/framerd.cfg
	rm ${D}/usr/share/framerd/framerd.cfg_orig
}

# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.94.0-r1.ebuild,v 1.3 2005/02/14 11:30:52 lanius Exp $

inherit libtool flag-o-matic multilib

DESCRIPTION="An OSF/Motif(R) clone"
HOMEPAGE="http://www.lesstif.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc ppc64 ~ppc-macos sparc x86"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"
#x11-libs/motif-config

PROVIDE="virtual/motif"

src_compile() {
	use ppc-macos || elibtoolize

	if use ppc-macos || macos ; then
		append-ldflags -L/usr/lib -lX11 -lXt
	fi

	econf \
	  --enable-production \
	  --enable-verbose=no \
	  --with-x || die "./configure failed"

	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	make DESTDIR=${D} install || die "make install"


	einfo "Fixing binaries"
	dodir /usr/bin/lesstif
	for file in `ls ${D}/usr/bin`
	do
		mv ${D}/usr/bin/${file} ${D}/usr/bin/${file}-lesstif
	done
	rm -f ${D}/usr/bin/lesstif/mxmkmf
	rm -fR ${D}/usr/bin


	einfo "Fixing docs"
	dodir /usr/share/doc/
	mv ${D}/usr/LessTif ${D}/usr/share/doc/${P}
	rm -fR ${D}/usr/$(get_libdir)/LessTif


	einfo "Fixing libraries"
	dodir /usr/$(get_libdir)/lesstif
	mv ${D}/usr/$(get_libdir)/$(get_libdir)* ${D}/usr/$(get_libdir)/lesstif


	einfo "Fixing includes"
	dodir /usr/include/lesstif/
	mv ${D}/usr/include/* ${D}/usr/include/lesstif
	rm -fR ${D}/usr/include


	einfo "Fixing man pages"
	dodir /usr/share/man/{man1,man3,man5}
	for file in `ls ${D}/usr/share/man/man1`
	do
		file=${file/.1/}
		mv ${D}/usr/share/man/man1/${file}.1 ${D}/usr/share/man/man1/${file}-lesstif.1
	done
	for file in `ls ${D}/usr/share/man/man3`
	do
		file=${file/.3/}
		mv ${D}/usr/share/man/man3/${file}.3 ${D}/usr/share/man/man3/${file}-lesstif.3
	done
	for file in `ls ${D}/usr/share/man/man6`
	do
		file=${file/.5/}
		mv ${D}/usr/share/man/man5/${file}.5 ${D}/usr/share/man/man5/${file}-lesstif.5
	done
	rm -fR ${D}/usr/share/man

	rm -fR ${D}/usr/share/aclocal

	# insinto /et/env.d/motif lesstif
	# motif-config lesstif
}

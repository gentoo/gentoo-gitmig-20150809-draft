# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/lesstif/lesstif-0.94.0-r1.ebuild,v 1.6 2005/02/14 19:26:06 lanius Exp $

inherit libtool flag-o-matic multilib

DESCRIPTION="An OSF/Motif(R) clone"
HOMEPAGE="http://www.lesstif.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~ppc-macos ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	virtual/x11
	x11-libs/motif-config"

PROVIDE="virtual/motif"

src_compile() {
	use ppc-macos || elibtoolize

	if use ppc-macos; then
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
	for file in `ls ${D}/usr/bin`
	do
		mv ${D}/usr/bin/${file} ${D}/usr/bin/${file}-lesstif
	done

	einfo "Fixing libraries"
	dodir /usr/$(get_libdir)/lesstif
	mv ${D}/usr/lib/* ${D}/usr/$(get_libdir)/lesstif/

	einfo "Fixing includes"
	dodir /usr/include/lesstif/
	mv ${D}/usr/include/* ${D}/usr/include/lesstif

	einfo "Fixing man pages"
	mans="1 3 5"
	for man in $mans; do
		dodir /usr/share/man/man${man}
		for file in `ls ${D}/usr/share/man/man${man}`
		do
			file=${file/.${man}/}
			mv ${D}/usr/share/man/man$man/${file}.${man} ${D}/usr/share/man/man${man}/${file}-lesstif.${man}
		done
	done


	einfo "Fixing docs"
	dodir /usr/share/doc/
	mv ${D}/usr/LessTif ${D}/usr/share/doc/${P}
	rm -fR ${D}/usr/$(get_libdir)/LessTif

	# cleanup
	rm -f ${D}/usr/bin/mxmkmf-lesstif
	rm -fR ${D}/usr/share/aclocal/
	rm -fR ${D}/usr/$(get_libdir)/lesstif/LessTif/
	rm -fR ${D}/usr/$(get_libdir)/X11/

}

# Profile stuff
pkg_postinst() {
	motif-config --install lesstif
}

pkg_postrm() {
	motif-config --uninstall lesstif
}

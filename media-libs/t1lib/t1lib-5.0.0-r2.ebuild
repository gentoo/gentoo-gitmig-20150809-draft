# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-5.0.0-r2.ebuild,v 1.9 2004/01/10 18:23:33 agriffis Exp $

inherit gnuconfig flag-o-matic

DESCRIPTION="A Type 1 Font Rasterizer Library for UNIX/X11"
HOMEPAGE="ftp://metalab.unc.edu/pub/Linux/libs/graphics"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/libs/graphics/${P}.tar.gz"

LICENSE="LGPL-2 GPL-2"
SLOT="5"
KEYWORDS="~x86 ~ppc ~sparc alpha hppa ~amd64 ia64"
IUSE="X doc"

DEPEND="X? ( virtual/x11 )"

src_unpack() {
	unpack ${A}
	if use amd64 || use alpha; then
		gnuconfig_update || die "gnuconfig_update failed"
	fi

	cd ${S}/doc
	mv Makefile.in Makefile.in-orig
	sed -e "s:dvips:#dvips:" Makefile.in-orig>Makefile.in
}

src_compile() {
	local myconf
	local myopt

	use alpha && append-flags -mieee

	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"

	if [ ! -x /usr/bin/latex ] ; then
		myopt="without_doc"
	fi

	echo `pwd`
	econf ${myconf} || die
	make ${myopt} || die
}

src_install() {
	cd lib
	insinto /usr/include
	doins t1lib.h

	use X && ( \
		doins t1libx.h
		ln -s -f libt1x.lai .libs/libt1x.la
		dolib .libs/libt1x.{la,a,so.${PV}}
		dosym libt1x.so.${PV} /usr/lib/libt1x.so.${PV%%.*}
		dosym libt1x.so.${PV} /usr/lib/libt1x.so
	)

	ln -s -f libt1.lai .libs/libt1.la
	dolib .libs/libt1.{la,a,so.${PV}}
	dosym libt1.so.${PV} /usr/lib/libt1.so.${PV%%.*}
	dosym libt1.so.${PV} /usr/lib/libt1.so
	insinto /etc/t1lib
	doins t1lib.config

	cd ..
	dodoc Changes LGPL LICENSE README*
	if [ `use doc` ] ; then
		cd doc
		insinto /usr/share/doc/${PF}
		doins *.pdf *.dvi
	fi
}

pkg_postinst() {
	ewarn
	ewarn "You must rebuild other packages depending on t1lib."
	ewarn "You may use revdep-rebuild (from app-portage/gentoolkit)"
	ewarn "to do all necessary tricks."
	ewarn
}

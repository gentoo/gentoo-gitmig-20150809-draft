# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/t1lib/t1lib-5.0.0-r2.ebuild,v 1.2 2003/08/15 13:04:39 lanius Exp $

inherit gnuconfig

IUSE="X tetex doc"

S=${WORKDIR}/${P}
DESCRIPTION="A Type 1 Rasterizer Library for UNIX/X11"
SRC_URI="ftp://sunsite.unc.edu/pub/Linux/libs/graphics/${P}.tar.gz"
HOMEPAGE="ftp://metalab.unc.edu/pub/Linux/libs/graphics"

DEPEND="X? ( virtual/x11 )
	tetex? ( virtual/tetex )"

SLOT="0"
LICENSE="LGPL-2 GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"

src_unpack() {
	unpack ${A}
	use amd64 && gnuconfig_update

	cd ${S}/doc
	mv Makefile.in Makefile.in-orig
	sed -e "s:dvips:#dvips:" Makefile.in-orig>Makefile.in

}

src_compile() {

	local myconf
	local myopt

	use X \
		&& myconf="--with-x" \
		|| myconf="--without-x"
	
	use tetex \
		|| myopt="without_doc"
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

pkg_postinst () {

	ewarn 
	ewarn "You must rebuild other packages depending on t1lib."
	ewarn "You may use revdep-rebuild (from app-portage/gentoolkit)"
	ewarn "to do all necessary tricks."
	ewarn
}

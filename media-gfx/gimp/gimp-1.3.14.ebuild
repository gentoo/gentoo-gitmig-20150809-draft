# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.3.14.ebuild,v 1.1 2003/04/16 12:40:19 foser Exp $

IUSE="doc python perl aalib png jpeg tiff gtkhtml"

inherit debug flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Development series of Gimp"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.3/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"
SLOT="2"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

replace-flags -Os -O2

RDEPEND=">=x11-libs/gtk+-2.2
	>=x11-libs/pango-1.2
	>=dev-libs/glib-2.2
	gtkhtml? ( =gnome-extra/libgtkhtml-2* )

	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	tiff? ( >=media-libs/tiff-3.5.7 )
	>=media-libs/libart_lgpl-2.3.8-r1

	aalib?	( media-libs/aalib )
	python?	( >=dev-lang/python-2.2
		>=dev-python/pygtk-1.99.13 )

	perl?	( dev-lang/perl )"


DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1 )"

src_compile() {

	# Strip out -fomit-frame-pointer for k6's
	is-flag "-march=k6*" && filter-flags "-fomit-frame-pointer"


	local myconf

	use doc \
		&& myconf="${myconf} --enable-gtk-doc" \
		|| myconf="${myconf} --disable-gtk-doc"
	use python \
		&& myconf="${myconf} --enable-python" \
		|| myconf="${myconf} --disable-python"
	use perl \
		&& myconf="${myconf} --enable-perl" \
		|| myconf="${myconf} --disable-perl"
	use png \
		&& myconf="${myconf} --with-libpng" \
		|| myconf="${myconf} --without-libpng"
	use libjpeg \
		&& myconf="${myconf} --with-libjpeg" \
		|| myconf="${myconf} --without-libjpeg"
	use tiff \
		&& myconf="${myconf} --with-libtiff" \
		|| myconf="${myconf} --without-libtiff"
	use gtkhtml \
		&& myconf="${myconf} --with-libtiff" \
		|| myconf="${myconf} --without-libtiff"

	myconf="${myconf} --disable-print"

	econf ${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} prefix=/usr \
		sysconfdir=/etc \
		infodir=/usr/share/info \
		mandir=/usr/share/man \
		localstatedir=/var/lib \
		install || die

	dodoc AUTHORS COPYING ChangeL* HACKING INSTALL MAINTAINERS NEWS PLUGIN_MAINTAINERS README* TODO*
}

pkg_postinst() {
	ewarn "There have been changes to the gtkrc file."
	ewarn
	ewarn "You are strongly advised to remove the ~/.gimp-1.3 directory"
	ewarn "and perform a fresh user installation if you have been"
	ewarn "running a gimp-1.3 below minor version 11"
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp/gimp-1.3.13.ebuild,v 1.3 2003/06/10 12:54:48 liquidx Exp $

IUSE="doc python aalib"

inherit debug flag-o-matic

S=${WORKDIR}/${P}
DESCRIPTION="Development series of Gimp"
SRC_URI="ftp://ftp.gimp.org/pub/gimp/v1.3/v${PV}/${P}.tar.bz2"
HOMEPAGE="http://www.gimp.org/"
SLOT="1.4"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc"

replace-flags -Os -O2

#libglade
RDEPEND=">=x11-libs/gtk+-2
	>=x11-libs/pango-1
	>=dev-libs/glib-2
	=gnome-extra/libgtkhtml-2*

	>=media-libs/libpng-1.2.1
	>=media-libs/jpeg-6b-r2
	>=media-libs/tiff-3.5.7
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
	is-flag "-march=k6-3" && strip-flags "-fomit-frame-pointer"
	is-flag "-march=k6-2" && strip-flags "-fomit-frame-pointer"
	is-flag "-march=k6" && strip-flags "-fomit-frame-pointer"


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

	myconf="${myconf} --disable-print"

	#econf --disable-perl --with-gnome-datadir=${D}/usr/share ${myconf} || die
	#econf --disable-perl ${myconf} --without-gnome-desktop || die
	# disable gnome-desktop since it breaks sandboxing

	econf ${myconf} || die

	# hack for odd make break
	touch plug-ins/common/${P}.tar.bz2

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

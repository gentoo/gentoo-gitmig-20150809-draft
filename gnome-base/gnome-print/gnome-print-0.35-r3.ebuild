# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.35-r3.ebuild,v 1.8 2002/07/19 12:47:19 stroke Exp $

S=${WORKDIR}/${P}
DESCRIPTION="GNOME printing library"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnome.org/"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"


RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/gnome-libs-1.4.1.4
	>=media-libs/freetype-2.0.1
	nls? ( sys-devel/gettext )"

DEPEND="${RDEPEND}
	sys-devel/perl
   	>=app-text/ghostscript-6.50-r2
	>=dev-libs/libxml-1.8.17
	tetex? ( app-text/tetex )"

src_unpack() {
	unpack ${A}

	#fix Makefile not to run gnome-font-install
	cp ${S}/installer/Makefile.in ${S}/installer/Makefile.in.orig
	sed -e 's:$(PERL) \($(top_srcdir)/run-gnome-font-install\):echo \1:' \
		${S}/installer/Makefile.in.orig > ${S}/installer/Makefile.in
}

src_compile() {
	libtoolize --copy --force

	local myconf=""
	use nls || myconf="${myconf} --disable-nls"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var/lib \
		${myconf} || die

	emake || die
}

src_install() {
	make DESTDIR=${D} 						\
		gnulocaledir=${D}/usr/share/locale	\
		sysconfdir=${D}/etc					\
		install || die

	insinto /usr/share/fonts
	doins ${S}/run-gnome-font-install

	dodoc AUTHORS COPYING ChangeLog NEWS README
}

pkg_postinst() {
	ldconfig >/dev/null 2>/dev/null
	einfo ">>> Installing fonts..."
	perl /usr/share/fonts/run-gnome-font-install \
		/usr/bin/gnome-font-install \
		/usr/share/fonts /usr/share/fonts /etc >/dev/null 2>/dev/null
}


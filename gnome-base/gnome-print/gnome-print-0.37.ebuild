# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.37.ebuild,v 1.4 2004/01/10 14:37:08 agriffis Exp $

inherit gnome.org libtool

IUSE="nls"

DESCRIPTION="GNOME printing library"
HOMEPAGE="http://www.gnome.org/"
KEYWORDS="~x86 ~ppc ~sparc alpha hppa ia64"
SLOT="0"
LICENSE="GPL-2"

RDEPEND=">=media-libs/gdk-pixbuf-0.11.0-r1
	>=gnome-base/gnome-libs-1.4.1.4
	>=dev-libs/libxml-1.8.8
	>=media-libs/freetype-2.0.1"

DEPEND="${RDEPEND}
	dev-lang/perl
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	#fix Makefile not to run gnome-font-install
	cp ${S}/installer/Makefile.in ${S}/installer/Makefile.in.orig
	sed -e 's:$(PERL) \($(top_srcdir)/run-gnome-font-install\):echo \1:' \
		${S}/installer/Makefile.in.orig > ${S}/installer/Makefile.in
}

src_compile() {

	elibtoolize

	econf `use_enable nls` || die

	emake || die

}

src_install() {

	einstall || die

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


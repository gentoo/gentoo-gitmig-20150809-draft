# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/gnome-print/gnome-print-0.37.ebuild,v 1.13 2004/11/08 16:15:39 vapier Exp $

inherit gnome.org libtool eutils

DESCRIPTION="GNOME printing library"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc64 sparc x86"
IUSE="nls"

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

	# fix build with freetype 2.1.7 and up (#44114)
	epatch ${FILESDIR}/${P}-freetype_new_include.patch

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


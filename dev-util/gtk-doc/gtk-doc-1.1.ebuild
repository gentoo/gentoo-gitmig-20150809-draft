# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-1.1.ebuild,v 1.1 2003/04/18 10:28:41 foser Exp $

inherit gnome.org

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/openjade-1.3.1
	=app-text/docbook-xml-dtd-4.1*
	>=app-text/docbook-dsssl-stylesheets-1.40
	>=dev-lang/perl-5.6
	dev-libs/libxslt
	>=dev-libs/libxml2-2.3.6
	!app-text/xhtml1"

src_compile() {
	local myconf

	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"
	
	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall

	dodoc AUTHORS ChangeLog COPYING INSTALL README* NEWS 
	docinto doc
	dodoc doc/README doc/*.txt
}

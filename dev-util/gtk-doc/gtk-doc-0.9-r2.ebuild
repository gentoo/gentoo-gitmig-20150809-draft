# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-0.9-r2.ebuild,v 1.13 2003/02/17 12:47:06 foser Exp $

inherit gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/openjade-1.3
	=app-text/docbook-sgml-dtd-4.1*
	>=app-text/sgml-common-0.6.1
	>=app-text/docbook-sgml-1.0
	>=sys-devel/perl-5.0.0"
		
src_compile() {
	econf --enable-debug=yes || die
	emake || die
}

src_install() {
	einstall || die
	
	dodoc AUTHORS ChangeLog COPYING INSTALL README* NEWS 
	docinto doc
	dodoc doc/README doc/*.txt
	
}

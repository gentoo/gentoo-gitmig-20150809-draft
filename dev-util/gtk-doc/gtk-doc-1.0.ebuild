# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-1.0.ebuild,v 1.10 2003/05/29 23:10:38 lu_zero Exp $

inherit gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc ~sparc ~alpha hppa"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/openjade-1.3.1
	=app-text/docbook-xml-dtd-4.1*
	>=app-text/docbook-dsssl-stylesheets-1.40
	>=dev-lang/perl-5
	dev-libs/libxslt
	>=dev-libs/libxml2-2.3.6
	!app-text/xhtml1"

src_compile() {
	local myconf

	if [ "${DEBUGBUILD}" ]
	then
		myconf="--enable-debug=yes"
	else
		myconf="--enable-debug=no"
	fi
	
	econf ${myconf}
	emake || die
}

src_install() {
	einstall

	dodoc AUTHORS ChangeLog COPYING INSTALL README* NEWS 
	docinto doc
	dodoc doc/README doc/*.txt
}

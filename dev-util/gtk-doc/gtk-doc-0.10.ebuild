# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-0.10.ebuild,v 1.4 2003/01/09 11:30:44 spider Exp $

inherit gnome.org

S=${WORKDIR}/${P}
DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc "

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=app-text/openjade-1.3
	>=app-text/docbook-sgml-dtd-4.1
	>=app-text/sgml-common-0.6.1
	>=app-text/docbook-sgml-1.0
	>=sys-devel/perl-5.0.0
	dev-libs/libxslt"
		
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

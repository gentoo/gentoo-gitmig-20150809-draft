# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-0.9-r2.ebuild,v 1.18 2004/02/14 16:46:46 spider Exp $

inherit gnome.org

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

RDEPEND=">=app-text/openjade-1.3
	=app-text/docbook-sgml-dtd-4.1*
	>=app-text/sgml-common-0.6.1
	>=app-text/docbook-sgml-1.0
	>=dev-lang/perl-5.0.0
	!app-text/xhtml1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	local myconf=""
	use debug \
		&& myconf="--enable-debug=yes" \
		|| myconf="--enable-debug=no"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die

	dodoc AUTHORS ChangeLog COPYING INSTALL README* NEWS
	docinto doc
	dodoc doc/README doc/*.txt

}

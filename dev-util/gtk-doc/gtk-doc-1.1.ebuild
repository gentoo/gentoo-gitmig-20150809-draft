# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-1.1.ebuild,v 1.24 2006/03/21 03:00:12 vapier Exp $

inherit gnome.org

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/gtk-doc/"
IUSE="debug"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 m68k mips ppc ppc64 sh sparc x86"

RDEPEND=">=app-text/openjade-1.3.1
	~app-text/docbook-xml-dtd-4.1.2
	>=app-text/docbook-dsssl-stylesheets-1.40
	>=dev-lang/perl-5.6
	dev-libs/libxslt
	>=dev-libs/libxml2-2.3.6"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"


src_compile() {
	local myconf
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

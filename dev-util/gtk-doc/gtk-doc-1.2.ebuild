# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-1.2.ebuild,v 1.6 2005/02/05 23:26:12 blubb Exp $

inherit elisp-common gnome2

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha arm ~hppa ~amd64 ~ia64"
IUSE="emacs"

DEPEND=">=app-text/openjade-1.3.1
	=app-text/docbook-xml-dtd-4.1*
	>=app-text/docbook-dsssl-stylesheets-1.40
	>=dev-lang/perl-5.6
	dev-libs/libxslt
	!app-text/xhtml1"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"

src_install() {
	gnome2_src_install

	docinto doc
	dodoc doc/*

	docinto examples
	dodoc examples/*

	if use emacs
	then
		elisp-compile tools/gtk-doc.el
		elisp-install ${PN} tools/gtk-doc.el*
	fi
}

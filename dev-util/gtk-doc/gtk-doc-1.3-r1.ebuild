# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-1.3-r1.ebuild,v 1.1 2005/04/06 01:02:28 leonardop Exp $

inherit eutils elisp-common gnome.org

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~hppa ~amd64 ~ia64 ~s390"
IUSE="emacs"

DEPEND=">=app-text/openjade-1.3.1
	=app-text/docbook-sgml-dtd-3.0*
	=app-text/docbook-xml-dtd-4.1.2*
	app-text/docbook-xsl-stylesheets
	>=app-text/docbook-dsssl-stylesheets-1.40
	>=dev-lang/perl-5.6
	>=dev-libs/libxml2-2.3.6
	dev-libs/libxslt
	!app-text/xhtml1"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix SGML declaration that was breaking compilation in some packages. See
	# bug #86716.
	epatch ${FILESDIR}/${P}-declaration.patch
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README TODO
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

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gtk-doc/gtk-doc-1.4-r1.ebuild,v 1.12 2006/05/03 00:59:53 flameeyes Exp $

inherit elisp-common gnome.org

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="http://www.gtk.org/gtk-doc/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE="emacs"

DEPEND=">=app-text/openjade-1.3.1
	~app-text/docbook-sgml-dtd-3.0
	~app-text/docbook-xml-dtd-4.1.2
	app-text/docbook-xsl-stylesheets
	>=app-text/docbook-dsssl-stylesheets-1.40
	>=dev-lang/perl-5.6
	>=dev-libs/libxml2-2.3.6
	dev-libs/libxslt
	emacs? ( virtual/emacs )"

SITEFILE="60gtk-doc-gentoo.el"


src_compile() {
	econf || die "Configuration failed"
	emake || die "Compilation failed"

	use emacs && elisp-compile tools/gtk-doc.el
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog MAINTAINERS NEWS README TODO
	docinto doc
	dodoc doc/*
	docinto examples
	dodoc examples/*

	if use emacs; then
		elisp-install ${PN} tools/gtk-doc.el*
		elisp-site-file-install ${FILESDIR}/${SITEFILE}
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-svn/uim-svn-20040124.ebuild,v 1.6 2004/04/07 11:52:39 hattya Exp $

inherit subversion flag-o-matic

IUSE="gtk nls debug"

ESVN_REPO_URI="http://freedesktop.org:8080/svn/uim/trunk"
ESVN_BOOTSTRAP="autogen.sh"
ESVN_PATCHES="*.diff"

DESCRIPTION="UIM is a simple, secure and flexible input method library"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI=""

LICENSE="GPL-2 | BSD"
KEYWORDS="~x86"
SLOT="0"

DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )"
RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	!app-i18n/uim"

src_compile() {

	if use gtk; then
		sed -i -e "s:@GTK2_TRUE@::g" -e "s:@GTK2_FALSE@:#:g" \
			Makefile.in `echo */Makefile.in`
	else
		sed -i -e "s:@GTK2_TRUE@:#:g" -e "s:@GTK2_FALSE@::g" \
			Makefile.in `echo */Makefile.in`
		sed -i -e "/^SUBDIRS/s/gtk//" Makefile.in
	fi

	use debug && append-flags -g
	econf `use_enable nls` || die
	emake || die

}

src_install() {

	make DESTDIR=${D} install || die

	dodoc [A-Z][A-Z]* ChangeLog* doc/[A-Z0-9][A-Z0-9]*

}

pkg_postinst() {

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules

	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo."
	einfo "To use uim-prime you should emerge app-i18n/prime."
	einfo

}

pkg_postrm() {

	use gtk && gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules

}

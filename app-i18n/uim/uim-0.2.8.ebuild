# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.2.8.ebuild,v 1.5 2004/04/06 04:03:27 vapier Exp $

inherit eutils

IUSE="gtk nls debug"

DESCRIPTION="UIM is a simple, secure and flexible input method library"
HOMEPAGE="http://uim.freedesktop.org/"
SRC_URI="http://freedesktop.org/Software/UimDownload/${P}.tar.gz"

LICENSE="GPL-2 | BSD"
SLOT="0"
KEYWORDS="x86 alpha"

S="${WORKDIR}/${P}"

DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )"
RDEPEND="gtk? ( =x11-libs/gtk+-2.2* )
	!app-i18n/uim-svn"

# for debugging use
use debug && RESTRICT="nostrip"

src_unpack() {

	unpack ${A}

	cd ${S}
	epatch ${FILESDIR}/${PN}-gtk-query-immodules-gentoo.diff
}

src_compile() {

	if [ -n "`use gtk`" ] ; then
		sed -i -e "s:@GTK2_TRUE@::g" -e "s:@GTK2_FALSE@:#:g" \
			Makefile.in `echo */Makefile.in`
	else
		sed -i -e "s:@GTK2_TRUE@:#:g" -e "s:@GTK2_FALSE@::g" \
			Makefile.in `echo */Makefile.in`
		sed -i -e "/^SUBDIRS/s/gtk//" Makefile.in
	fi

	use debug && export CFLAGS="${CFLAGS} -g"
	econf `use_enable nls` || die
	emake || die
}

src_install () {

	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL* NEWS README*
}

pkg_postinst() {

	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo (uim doesn't support skkserv)."
	einfo "To use uim-prime you should emerge app-i18n/prime and make sure you have"
	einfo ">=dev-libs/suikyo-1.3.0."
	einfo

	if [ "`use gtk`" ] ; then
		gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
	fi
}

pkg_postrm() {

	if [ "`use gtk`" ] ; then
		gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
	fi
}

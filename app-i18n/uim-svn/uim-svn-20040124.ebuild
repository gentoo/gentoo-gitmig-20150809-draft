# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim-svn/uim-svn-20040124.ebuild,v 1.3 2004/01/28 09:44:54 hattya Exp $

inherit subversion

IUSE="gtk nls debug"

DESCRIPTION="UIM is a simple, secure and flexible input method library"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI=""
ESVN_REPO_URI="http://freedesktop.org:8080/svn/uim/trunk"
ESVN_BOOTSTRAP="autogen.sh"

LICENSE="GPL-2 | BSD"
SLOT="0"
KEYWORDS="~x86"

S="${WORKDIR}/${P}"

DEPEND="${RDEPEND}
	dev-lang/perl
	dev-perl/XML-Parser
	>=sys-apps/sed-4
	nls? ( sys-devel/gettext )"
RDEPEND="gtk? ( >=x11-libs/gtk+-2 )
	!app-i18n/uim"

# for debugging use
use debug && RESTRICT="nostrip"

src_compile() {

	epatch ${FILESDIR}/${PN}-gtk-query-immodules-gentoo.diff

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

	if [ "`use gtk`" ] ; then
		dodir /etc/gtk-2.0
	fi

	make DESTDIR=${D} install || die

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL* NEWS README*
}

pkg_postinst() {

	einfo
	einfo "To use uim-anthy you should emerge app-i18n/anthy or app-i18n/anthy-ss."
	einfo "To use uim-skk you should emerge app-i18n/skk-jisyo."
	einfo "To use uim-prime you should emerge app-i18n/prime."
	einfo
}

pkg_postrm() {

	if [ "`use gtk`" ] ; then
		gtk-query-immodules-2.0 > /etc/gtk-2.0/gtk.immodules
	fi
}

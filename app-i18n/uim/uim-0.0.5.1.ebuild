# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.0.5.1.ebuild,v 1.1 2003/09/10 16:11:53 usata Exp $

IUSE="gtk nls"

DESCRIPTION="UIM is a simple, secure and flexible input method library"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5903/${P}.tar.gz"

LICENSE="GPL-2 | BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	>=dev-libs/glib-2
	gtk? ( >=x11-libs/gtk+-2 )
	>=sys-apps/sed-4"
DEPEND="virtual/glibc
	>=dev-libs/glib-2
	gtk? ( >=x11-libs/gtk+-2 )"

GTK_IMMODULES=/etc/gtk-2.0/gtk.immodules

src_compile() {

	if [ -n "`use gtk`" ] ; then
		sed -i -e "s:@GTK2_TRUE@::g" -e "s:@GTK2_FALSE@:#:g" \
			Makefile.in `echo */Makefile.in`
	else
		sed -i -e "s:@GTK2_TRUE@:#:g" -e "s:@GTK2_FALSE@::g" \
			Makefile.in `echo */Makefile.in`
		sed -i -e "/^SUBDIRS/s/gtk//" Makefile.in
	fi

	econf `use_enable nls` || die
	emake || die
}

src_install () {

	einstall || die

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL* NEWS README*
}

pkg_postinst() {

	if [ -f ${GTK_IMMODULES} ] ; then
		gtk-query-immodules-2.0 > ${GTK_IMMODULES}
	fi
}

pkg_postrm() {

	if [ -f ${GTK_IMMODULES} ] ; then
		gtk-query-immodules-2.0 > ${GTK_IMMODULES}
	fi
}

# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/uim/uim-0.0.2.1.ebuild,v 1.1 2003/08/31 21:54:38 usata Exp $

IUSE="gtk nls canna"

DESCRIPTION="UIM is a simple, secure and flexible input method library"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5771/${P}.tar.gz"

LICENSE="GPL-2 | BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc"

S="${WORKDIR}/${P}"

DEPEND="virtual/glibc
	gtk? ( >=x11-libs/gtk+-2 )
	canna? ( app-i18n/canna )"

GTK_IMMODULES=/etc/gtk-2.0/gtk.immodules

src_compile() {

	econf \
		`use_with gtk` \
		`use_enable nls` \
		`use_with canna` || die
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

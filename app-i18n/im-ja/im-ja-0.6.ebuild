# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/im-ja/im-ja-0.6.ebuild,v 1.3 2003/09/05 02:52:23 usata Exp $

inherit eutils

DESCRIPTION="A Japanese input module for GTK2"
HOMEPAGE="http://im-ja.sourceforge.net/"
SRC_URI="${HOMEPAGE}${P}.tar.gz
	${HOMEPAGE}old/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="x86 ~sparc"
SLOT=0

IUSE="canna freewnn"

DEPEND="virtual/glibc
	>=dev-libs/glib-2.2.1
	>=dev-libs/atk-1.2.2
	>=x11-libs/gtk+-2.2.1
	>=x11-libs/pango-1.2.1
	>=gnome-base/gconf-2.2
	freewnn? ( app-i18n/freewnn )
	canna? ( app-i18n/canna )"

GCONFDIR=$(gconftool-2 --get-default-source | sed -e "s|^xml::/|${D}|")

src_unpack() {

	unpack ${A}
	epatch ${FILESDIR}/${P}-gentoo.diff

	cd ${S}/data
	# work around
	sed -i -e "s:\(GCONF_CONFIG_SOURCE=\)\$(GCONF_CONFIG_SOURCE):\1\$(GCONF_SCHEMA_CONFIG_SOURCE):" Makefile.in
}

src_compile() {

	local myconf

	if [ -n "`use canna`" ] ; then
		export CPPFLAGS="${CPPFLAGS} -I/usr/include/canna"
	else
		myconf="${myconf} --disable-canna"
	fi
	if [ -n "`use freewnn`" ] ; then
		export CPPFLAGS="${CPPFLAGS} -I/usr/include/wnn"
	else
		myconf="${myconf} --disable-wnn"
	fi

	econf --with-gconf-source=xml::${GCONFDIR} \
		${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install () {

	einstall || die

	# /etc/gconf should be world readable
	find ${GCONFDIR} -type d | xargs chmod -R +rx
	find ${GCONFDIR} -type f | xargs chmod -R +r

	dodoc AUTHORS README ChangeLog TODO NEWS
}

pkg_postinst(){

	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}

pkg_postrm(){

	gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
}

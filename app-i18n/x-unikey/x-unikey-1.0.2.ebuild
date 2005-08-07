# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/x-unikey/x-unikey-1.0.2.ebuild,v 1.1 2005/08/07 15:24:37 pclouds Exp $

inherit eutils

DESCRIPTION="Vietnamese X Input Method"
HOMEPAGE="http://unikey.sourceforge.net/linux.php"
SRC_URI="mirror://sourceforge/unikey/${P}.tar.bz2
	doc? ( http://unikey.org/manual/x-unikey-manual.html http://unikey.org/manual/x-unikey-manual.pdf )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls gtk doc"

DEPEND="virtual/x11
	nls? ( sys-devel/gettext )
	gtk? ( >=x11-libs/gtk+-2.2 )"

src_unpack() {
	unpack ${P}.tar.bz2 || die "unpack failed"
	if use doc; then
		cp ${DISTDIR}/x-unikey-manual.html ${DISTDIR}/x-unikey-manual.pdf ${WORKDIR}/${P}/doc
	fi
}

src_compile() {
	local myconf
	# --with-gtk-sysconfdir to prevent sandbox violation only
	use gtk && myconf="--with-unikey-gtk --with-gtk-sysconfdir=${D}/etc/gtk-2.0"
	econf ${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	if use gtk;then
		dodir etc/gtk-2.0
		make DESTDIR=${D} install -C src/unikey-gtk
	fi
	dobin src/xim/ukxim src/gui/unikey
	insinto /etc/env.d
	doins ${FILESDIR}/01x-unikey
	dodoc doc/*
}

pkg_postinst() {
	einfo ""
	einfo "Go to /etc/env.d/01x-unikey and uncomment appropriate lines"
	einfo "to enable x-unikey"
	einfo ""
	if use gtk; then
		gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
		einfo "If you want to use x-unikey as the default gtk+ input method,"
		einfo "change GTK_IM_MODULE in /etc/env.d/01x-unikey to \"unikey\""
		einfo ""
	fi
}

pkg_postrm() {
	if use gtk; then
		gtk-query-immodules-2.0 > ${ROOT}/etc/gtk-2.0/gtk.immodules
	fi
}

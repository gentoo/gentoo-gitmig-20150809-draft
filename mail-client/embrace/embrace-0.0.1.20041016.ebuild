# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/mail-client/embrace/embrace-0.0.1.20041016.ebuild,v 1.1 2004/10/18 13:57:43 vapier Exp $

inherit enlightenment

DESCRIPTION="mail-checker which is based on the EFL"

IUSE="ssl mbox maildir"

DEPEND=">=x11-libs/ecore-1.0.0.20041009_pre7
	>=x11-libs/evas-1.0.0.20041009_pre13
	>=media-libs/edje-0.5.0.20041009
	>=x11-libs/esmart-0.9.0.20041009
	ssl? ( dev-libs/openssl )
	sys-devel/libtool"

src_compile() {
	export MY_ECONF="
		$(use_enable ssl) \
		$(use_with mbox) \
		$(use_with maildir) \
		--with-pop \
		$(use_with imap) \
	"
	enlightenment_src_compile
}

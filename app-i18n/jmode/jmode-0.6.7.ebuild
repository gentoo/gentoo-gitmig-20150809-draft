# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/jmode/jmode-0.6.7.ebuild,v 1.5 2004/11/23 09:07:37 usata Exp $

DESCRIPTION="a Japanese IME supporting Anthy"
HOMEPAGE="http://anthy.sourceforge.jp/"
SRC_URI="mirror://sourceforge.jp/anthy/5467/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gnome"

DEPEND="=x11-libs/gtk+-1.2*
	app-i18n/anthy
	gnome? ( gnome-base/gnome-panel )"

src_compile() {
	# --with-skk and --with-engine=anthy are exclusive
	econf $(use_with gnome) \
		--with-engine=anthy || die
	emake CPPFLAGS="${CPPFLAGS} -DCONF_DIR=\\\"/etc/jmode/\\\"" || die
}

src_install() {
	make DESTDIR=${D} pkgdatadir=/etc/jmode install || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README
}

pkg_postinst() {
	einfo
	einfo "jmode is deprecated and not supported by upstream anymore."
	einfo " Please consider switching to app-i18n/uim."
	einfo
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xdialog/xdialog-2.2.1-r1.ebuild,v 1.2 2007/01/03 03:05:00 beandog Exp $

DESCRIPTION="drop-in replacement for cdialog using GTK"
HOMEPAGE="http://xdialog.dyns.net/"
SRC_URI="http://thgodef.nerim.net/xdialog/Xdialog-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ppc ~x86"
IUSE="nls"

DEPEND=">=x11-libs/gtk+-2.2
	nls? ( >=sys-devel/gettext-0.10.38 )"

S="${WORKDIR}/${P/x/X}"

src_compile() {
	econf $(use_enable nls) --with-gtk2 || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}/usr/share/doc"
	dodoc ChangeLog AUTHORS README
	dohtml -r doc/
}

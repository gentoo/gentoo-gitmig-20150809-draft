# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/kiso/kiso-0.6.ebuild,v 1.2 2004/11/11 23:57:08 motaboy Exp $

inherit kde

RESTRICT="nomirror"
DESCRIPTION="KIso is a fronted for KDE to make it as easy as possible to create manipulate and extract CD Image files."
HOMEPAGE="http://kiso.sourceforge.net/"
SRC_URI="mirror://sourceforge/kiso/kiso-${PV}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc"

SLOT="0"
IUSE=""

DEPEND=">=dev-libs/libcdio-0.69"
RDEPEND="${DEPEND}
	app-cdr/cdrtools
	app-admin/sudo"

need-kde 3.2

src_compile() {
	addwrite $QTDIR/etc/settings
	econf || die
	emake || die
}

src_install() {
	addwrite $QTDIR/etc/settings
	einstall || die
}


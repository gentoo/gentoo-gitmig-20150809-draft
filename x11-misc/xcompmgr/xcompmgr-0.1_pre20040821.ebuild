# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/xcompmgr/xcompmgr-0.1_pre20040821.ebuild,v 1.1 2004/08/21 18:29:01 seemant Exp $

IUSE=""

S=${WORKDIR}/${PN}
DESCRIPTION="X Compositing manager"
HOMEPAGE="http://freedesktop.org/Software/xapps"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86"

RDEPEND=">=x11-base/xorg-x11-6.7.99.902"

DEPEND="${RDEPEND}
	>=sys-devel/automake-1.7
	>=sys-devel/autoconf-2.5"

src_compile() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.7
	./autogen.sh || die
	econf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ChangeLog
}

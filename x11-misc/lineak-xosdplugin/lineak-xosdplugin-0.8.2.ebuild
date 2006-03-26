# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/lineak-xosdplugin/lineak-xosdplugin-0.8.2.ebuild,v 1.3 2006/03/26 00:34:14 genstef Exp $

inherit eutils

IUSE=""
MY_PV=${PV/_/}
MY_P=${PN/-/_}-${MY_PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="Xosd plugin for LINEAK"
HOMEPAGE="http://lineak.sourceforge.net/"
SRC_URI="mirror://sourceforge/lineak/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"

RDEPEND="=x11-misc/lineakd-${PV}*
		x11-libs/xosd"
DEPEND="${RDEPEND}"

src_compile() {
	epatch ${FILESDIR}/do-not-depend-on-kde.patch

	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5
	make -f Makefile.dist || die "autotools failed"

	econf --with-x || die "econf failed"

	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} lineakddocdir=/usr/share/doc/${P} install || die
	dodoc AUTHORS README TODO
}

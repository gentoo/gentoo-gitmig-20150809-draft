# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skkinput/skkinput-3.0.6.20031012b.ebuild,v 1.4 2004/06/28 02:04:39 vapier Exp $

inherit eutils

MY_P="${PN}${PV%%.*}-snap${PV##*.}"

DESCRIPTION="A SKK-like Japanese input method for X11"
HOMEPAGE="http://www.tatari-sakamoto.jp/~tatari/skkinput3.jis.html"
SRC_URI="http://member.nifty.ne.jp/Tatari_SAKAMOTO/arc/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="3"
KEYWORDS="~x86 ~ppc ~sparc alpha"
IUSE=""

DEPEND="virtual/libc
	virtual/x11"
RDEPEND="${DEPEND}
	virtual/skkserv"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P%.*}-gentoo.diff
}

src_compile() {
	xmkmf -a || die
	make || die
}

src_install() {
	einstall DESTDIR=${D} || die

	dodoc ChangeLog *.jis

	insinto /etc/skel
	newins dot.skkinput .skkinput.el
}

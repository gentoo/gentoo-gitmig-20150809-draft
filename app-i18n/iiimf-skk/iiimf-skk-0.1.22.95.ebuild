# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/iiimf-skk/iiimf-skk-0.1.22.95.ebuild,v 1.1 2004/09/14 08:02:52 usata Exp $

inherit eutils

DESCRIPTION="SKK Language Engine inputh method module for IIIMF"
HOMEPAGE="http://www.momonga-linux.org/~famao/iiimf-skk/"
SRC_URI="mirror://sourceforge.jp/iiimf-skk/9344/${P}.tar.gz
	http://dev.gentoo.org/~usata/misc/${P}-db4-gentoo.diff.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="nls gtk2 canna debug"

DEPEND="virtual/libc
	>=sys-libs/db-3
	gtk2? ( =x11-libs/gtk+-2* )
	!gtk2? ( =x11-libs/gtk+-1.2* )
	dev-libs/libxml2
	app-i18n/im-sdk
	virtual/skkserv
	canna? ( app-i18n/canna )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	epatch ${DISTDIR}/${P}-db4-gentoo.diff.gz
}

src_compile() {

	econf \
		`use_enable nls` \
		`use_enable gtk2` \
		`use_enable debug` \
		`use_enable canna` \
		--with-skkserv-host="localhost" \
		--with-skkserv-port=1178 \
		|| die "econf failed"
	emake -j1 || die
}

src_install () {

	make DESTDIR=${D} install || die

	newbin ${FILESDIR}/iiimf-skk.sh iiimf-skk

	dodoc ABOUT-NLS AUTHORS ChangeLog INSTALL NEWS README
}

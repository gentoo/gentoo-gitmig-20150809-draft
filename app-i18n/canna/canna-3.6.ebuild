# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/canna/canna-3.6.ebuild,v 1.7 2003/08/05 15:39:29 vapier Exp $

inherit eutils

MY_P="Canna36"

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://canna.sourceforge.jp/"
SRC_URI="http://downloads.sourceforge.jp/canna/1425/${MY_P}.tar.gz"

LICENSE="as-is"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha"

DEPEND="virtual/glibc"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PF}-gentoo.diff
}

src_compile() {
	xmkmf || die
	make Makefiles || die
	# make includes
	make canna || die
}

src_install() {
	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	dodoc CHANGES.jp ChangeLog INSTALL* README* WHATIS*
	exeinto /etc/init.d ; newexe ${FILESDIR}/canna.initd canna || die
	insinto /etc/conf.d ; newins ${FILESDIR}/canna.confd canna || die
}

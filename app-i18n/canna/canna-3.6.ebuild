# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/canna/canna-3.6.ebuild,v 1.4 2002/12/15 10:44:11 bjb Exp $

MY_P="Canna36"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A client-server based Kana-Kanji conversion system"
HOMEPAGE="http://canna.sourceforge.jp/"
KEYWORDS="x86 ~ppc ~sparc ~alpha"
LICENSE="as-is"
SLOT="0"
IUSE=""
SRC_URI="http://downloads.sourceforge.jp/canna/1425/${MY_P}.tar.gz"
DEPEND="virtual/glibc"

src_unpack() {

	unpack ${A}
	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die
}

src_compile() {

	xmkmf || die
	make Makefiles || die
	# make includes
	make canna || die
}

src_install () {

	make DESTDIR=${D} install || die
	make DESTDIR=${D} install.man || die
	dodoc CHANGES.jp ChangeLog INSTALL* README* WHATIS*
	exeinto /etc/init.d ; newexe ${FILESDIR}/canna.initd canna || die
	insinto /etc/conf.d ; newins ${FILESDIR}/canna.confd canna || die
}


# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Michael Conrad Tilstra <michael@gentoo.org> <tadpol@tadpol.org>
# $Header: /var/cvsroot/gentoo-x86/net-news/knews/knews-1.0.1b-r2.ebuild,v 1.5 2003/04/23 00:10:41 lostlogic Exp $

IUSE="xface png jpeg"

MY_P=${PN}-1.0b.1
S=${WORKDIR}/${MY_P}
DESCRIPTION="A threaded newsreader for X."
SRC_URI="http://www.matematik.su.se/~kjj/${MY_P}.tar.gz
	mirror://gentoo/${MY_P}-gentoo.diff.bz2"
HOMEPAGE="http://www.matematik.su.se/~kjj/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="virtual/x11
	virtual/mta
	=sys-apps/sed-4*
	jpeg? ( >=media-libs/jpeg-6 )
	png? ( >=media-libs/libpng-1.2.1 )
	xface? ( >=media-libs/compface-1.4 )"

# If knews used autoconf, we wouldn't need this patch.
src_unpack() {
	unpack ${A}
	cd ${S}
	use jpeg \
		&& sed -i "s:\(#define HAVE_JPEG\).*:\1\t1:" configure.h

	use png \
		&& sed -i "s:\(#define HAVE_PNG\).*:\1\t1:" configure.h

	use xface \
		&& sed -i "s:\(#define HAVE_COMPFACE\).*:\1\t1:" configure.h

	sed -i "s:\(#define HAVE_XPM\).*:\1\t1:" configure.h

	sed -i "s:\(#define DEFAULT_EDIT_COMMAND\).*:\1 \"${EDITOR} %s\":" configure.h

	patch -p1 < ${WORKDIR}/${MY_P}-gentoo.diff || die
}

src_compile() {
	xmkmf || die
	make Makefiles || die
	make clean || die
	make all || die
	pushd util/knewsd || die
	xmkmf || die
	make all || die
	popd || die
}

src_install () {
	#Install knews
	make DESTDIR=${D} install || die
	make DESTDIR=${D} DOCHTMLDIR=/usr/share/doc/${P} \
	MANPATH=/usr/share/man MANSUFFIX=1 install.man || die

	dodir /etc/knews
	touch ${D}/etc//knews/mailname
	touch ${D}/etc/knews/newsserver

	#Other docs.
	dodoc COPYING COPYRIGHT Changes README
}


pkg_postinst() {

	einfo "Please be sure to set your local domain in"
	einfo "    /etc/knews/mailname"
	einfo ""
	einfo "And please set your news server in"
	einfo "    /etc/knews/newsserver"
}

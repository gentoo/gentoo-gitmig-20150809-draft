# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Added ssl support and new patches
# $Header $
 
S=${WORKDIR}/${P}
DESCRIPTION="s-lang Newsreader"
PATCH_URI="http://slrn.sourceforge.net/patches"
SRC_URI="mirror://sourceforge/slrn/${P}.tar.bz2
${PATCH_URI}/${P}-mem_leak.diff
${PATCH_URI}/${P}-popup_win.diff"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

HOMEPAGE="http://slrn.sourceforge.net/"
DEPEND="virtual/glibc
	virtual/mta
	>=sys-apps/sharutils-4.2.1
	>=sys-libs/slang-1.4.4
	ssl? ( >=dev-libs/openssl-0.9.6 )"

src_unpack() {
	unpack ${P}.tar.bz2
	cd ${S}
	for i in ${P}-{mem_leak,popup_win}.diff ; do
		patch -p1 < ${DISTDIR}/${i}
	done
}

src_compile() {
	local myconf
	use ssl && myconf="--with-ssl=/usr" \
		|| myconf="--without-ssl"
	./configure --infodir=/usr/share/info \
		--mandir=/usr/share/man --prefix=/usr \
		--with-slrnpull --host=${CHOST} $myconf \
		|| die "./configure failed (myconf=$myconf)"
	emake || die
}

src_install () {
	
	make DESTDIR=${D} DOCDIR=/usr/share/doc/${P} install || die
	find $D/usr/share/doc -type f | xargs gzip
}

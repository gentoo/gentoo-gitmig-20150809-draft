# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supersed/supersed-3.58-r1.ebuild,v 1.1 2002/08/23 11:12:31 seemant Exp $

MY_P=sed-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An enhanced version of sed which sports greater speed and the use of perl regular expressions than GNU sed."
SRC_URI="http://queen.rett.polimi.it/~paolob/seders/ssed/${MY_P}.tar.gz"
HOMEPAGE="http://queen.rett.polimi.it/~paolob/seders/ssed/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc sparc64"

DEPEND="dev-libs/libpcre
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls ||  myconf="--disable-nls"
	use static \
		&& myconf="${myconf} --disable-html" \
		|| myconf="${myconf} --enable-html"
	
	if [ -f /usr/bin/sed ]
	then
		echo "simple conf"
		econf ${myconf} || die
	else
		echo "bootstrap"
		./bootstrap.sh
		econf ${myconf} || die
	fi

	if [ -z "`use static`" ]
	then
		emake || die
	else
		emake LDFLAGS=-static || die
	fi
}

src_install() {
	mv sed/sed sed/ssed

	into /
	dobin sed/ssed
	dodir /usr/bin
	dosym ../../bin/ssed /usr/bin/ssed

	use build \
		&& rm -rf ${D}/usr/share \
		|| dodoc COPYING NEWS README* THANKS TODO AUTHORS BUGS
}

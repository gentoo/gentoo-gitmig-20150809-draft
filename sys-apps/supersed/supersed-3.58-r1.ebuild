# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/supersed/supersed-3.58-r1.ebuild,v 1.13 2004/07/22 04:33:53 vapier Exp $

MY_P=sed-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="An enhanced version of sed which sports greater speed and the use of perl regular expressions than GNU sed."
HOMEPAGE="http://sed.sourceforge.net/grabbag/ssed/"
SRC_URI="http://sed.sourceforge.net/grabbag/ssed/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc amd64"
IUSE="nls static build"

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

	if ! use static
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

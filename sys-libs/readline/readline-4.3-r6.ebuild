# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/readline/readline-4.3-r6.ebuild,v 1.2 2004/07/27 14:29:18 vapier Exp $

inherit eutils gnuconfig

# Official patches
PLEVEL="x001 x002 x003 x004 x005"

DESCRIPTION="Another cute console display library"
HOMEPAGE="http://cnswww.cns.cwru.edu/php/chet/readline/rltop.html"
SRC_URI="ftp://ftp.gnu.org/gnu/readline/${P}.tar.gz
	 ftp://gatekeeper.dec.com/pub/GNU/readline/${P}.tar.gz
	 ${PLEVEL//x/ftp://ftp.gnu.org/gnu/${PN}/${PN}-${PV}-patches/${PN}${PV/\.}-}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="macos" # Only changed Darwin specific part, should work just fine on other archs.
IUSE=""

# We must be certain that we have a bash that is linked
# to its internal readline, else we may get problems.
DEPEND=">=app-shells/bash-2.05b-r2
	>=sys-libs/ncurses-5.2-r2"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	for x in ${PLEVEL//x}
	do
		epatch ${DISTDIR}/${PN}${PV/\.}-${x}
	done
	use macos && epatch ${FILESDIR}/macos.patch

	gnuconfig_update
}

src_compile() {
	econf --with-curses || die

	emake || die
	cd shlib
	emake || die
}


src_install() {
	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die
	cd ${S}/shlib
	make prefix=${D}/usr mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info install || die

	cd ${S}

	if ! use macos; then
		dodir /lib
		mv ${D}/usr/lib/*.so* ${D}/lib
		rm -f ${D}/lib/*.old
		# bug #4411
		gen_usr_ldscript libreadline.so
		gen_usr_ldscript libhistory.so
		# end bug #4411
		dosym libhistory.so.${PV/a/} /lib/libhistory.so
		dosym libreadline.so.${PV/a/} /lib/libreadline.so
		# Needed because make install uses ${D} for the link
		dosym libhistory.so.${PV/a/} /lib/libhistory.so.4
		dosym libreadline.so.${PV/a/} /lib/libreadline.so.4
		chmod 755 ${D}/lib/*.${PV/a/}
	fi

	dodoc CHANGELOG CHANGES README USAGE
	docinto ps
	dodoc doc/*.ps
	dohtml -r doc
}

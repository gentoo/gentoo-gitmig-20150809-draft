# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-21.2-r1.ebuild,v 1.1 2003/03/20 13:22:51 seemant Exp $

IUSE="nls"

DESCRIPTION="A set of tools that use the proc filesystem"
SRC_URI="mirror://sourceforge/psmisc/${P}.tar.gz"
HOMEPAGE="http://psmisc.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa arm mips"

DEPEND=">=sys-libs/ncurses-5.2-r2"

src_compile() {
	local myconf="--with-gnu-ld"
	use nls || myconf="${myconf} --disable-nls"

	econf ${myconf} || die
	emake || die
}

src_install() {
	einstall || die
	dosym killall /usr/bin/pidof
	dodoc ABOUT-NLS AUTHORS ChangeLog NEWS README

	# some packages expect these to use /usr, others to use /
	dodir /bin
	mv ${D}/usr/bin/* ${D}/bin/
	cd ${D}/bin
	for f in * ; do
		dosym /bin/${f} /usr/bin/${f}
	done
}

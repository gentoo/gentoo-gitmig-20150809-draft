# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/psmisc/psmisc-21.2-r2.ebuild,v 1.1 2003/05/18 23:36:07 azarah Exp $

IUSE="nls selinux"

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="mirror://sourceforge/psmisc/${P}.tar.gz
    selinux? mirror://gentoo/${P}-selinux.patch.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~arm ~mips"

DEPEND=">=sys-libs/ncurses-5.2-r2
    selinux? ( >=sys-apps/selinux-small-2003011510-r2 )"

src_unpack() {
    unpack ${A}
    cd ${S}

    # Necessary selinux patch 
    use selinux && epatch ${DISTDIR}/${P}-selinux.patch.bz2

	# Fix gcc-3.3 compile issues.
	# <azarah@gentoo.org> (18 May 2003)
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	local myconf="--with-gnu-ld"
	use nls || myconf="${myconf} --disable-nls"
	use selinux && myconf="${myconf} --enable-flask"

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

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.6.1.ebuild,v 1.4 2002/08/14 04:40:34 murphy Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/parted"
KEYWORDS="x86 ppc sparc sparc64"
DEPEND="virtual/glibc
	>=sys-apps/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2
	readline? ( >=sys-libs/readline-4.1-r4 )
	nls? ( sys-devel/gettext )"
# masked out for now.  any objections to enabling this per default?
# //woodchip
#RDEPEND="${DEPEND} =dev-libs/progsreiserfs-0.3.0*"
LICENSE="GPL-2"
SLOT="0"

src_unpack() {
	unpack ${A}
	cd ${S}
	#fix a manpage glitch
	patch -p1 <${FILESDIR}/${PN}-1.6.0-destdir.patch || die
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use readline || myconf="${myconf} --without-readline"
	[ -z "${DEBUGBUILD}" ] && myconf="${myconf} --disable-debug"
	use static && myconf="${myconf} --enable-all-static"
	econf --target=${CHOST} ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog \
		INSTALL NEWS README THANKS TODO
	docinto doc; cd doc
	dodoc API COPYING.DOC FAQ FAT USER USER.jp
}

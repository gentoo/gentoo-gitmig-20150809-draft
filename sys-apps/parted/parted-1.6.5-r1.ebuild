# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.6.5-r1.ebuild,v 1.12 2004/02/02 17:54:50 plasmaroo Exp $

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="http://www.gnu.org/software/parted"
SRC_URI="mirror://gentoo/${P}.tar.gz
	mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc amd64 alpha"
IUSE="nls static readline debug noreiserfs"

DEPEND=">=sys-fs/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	readline? ( >=sys-libs/readline-4.1-r4 )"
RDEPEND="${DEPEND}
	!noreiserfs ( =sys-fs/progsreiserfs-0.3.0* )"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/parted-1.6.5-hfs-8.patch
	epatch ${FILESDIR}/parted-1.6.5-gcc-3.3.patch
}

src_compile() {
	local myconf
	use nls || myconf="${myconf} --disable-nls"
	use readline || myconf="${myconf} --without-readline"
	use debug || myconf="${myconf} --disable-debug"
	use static && myconf="${myconf} --enable-all-static"
	econf --target=${CHOST} ${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog \
		INSTALL NEWS README THANKS TODO
	docinto doc; cd doc
	dodoc API COPYING.DOC FAQ FAT USER USER.jp
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.6.6.ebuild,v 1.21 2004/07/15 02:02:41 agriffis Exp $

inherit gnuconfig eutils

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="http://www.gnu.org/software/parted"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${P}.tar.gz
	mirror://gentoo/${PF}-gentoo.tar.bz2
	http://dev.gentoo.org/~seemant/extras/${PF}-gentoo.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ia64 x86 ~ppc amd64 sparc hppa alpha"
IUSE="nls static readline debug"

DEPEND=">=sys-fs/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	readline? ( >=sys-libs/readline-4.1-r4 )"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	unpack ${A}
	cd ${S}
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
}

src_compile() {
	gnuconfig_update

	econf \
		`use_with readline` \
		`use_enable nls` \
		`use_enable debug` \
		`use_enable static all-static` \
		--disable-Werror \
		--target=${CHOST} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog \
		INSTALL NEWS README THANKS TODO
	docinto doc; cd doc
	dodoc API COPYING.DOC FAQ FAT USER USER.jp
}

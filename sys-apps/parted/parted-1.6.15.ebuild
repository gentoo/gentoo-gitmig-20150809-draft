# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.6.15.ebuild,v 1.4 2004/11/30 20:56:03 lu_zero Exp $

inherit eutils gnuconfig

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="http://www.gnu.org/software/parted"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz
	mirror://gentoo/${PF}-gentoo.tar.bz2
	mirror://gentoo/${P}.tar.gz
	http://dev.gentoo.org/~lu_zero/distfiles/${PF}-gentoo.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ppc ~alpha hppa ~amd64 ~ia64 ppc64"
IUSE="nls static readline debug"

DEPEND=">=sys-fs/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	readline? ( >=sys-libs/readline-4.1-r4 )"

PATCHDIR=${WORKDIR}/patches

src_unpack() {
	local WANT_AUTOCONF=1.7
	unpack ${A}
	cd ${S}
	EPATCH_SUFFIX="patch" epatch ${PATCHDIR}
	gnuconfig_update
	libtoolize --force
	aclocal
	autoconf
}

src_compile() {
	econf \
		`use_with readline` \
		`use_enable nls` \
		`use_enable debug` \
		`use_enable static all-static` \
		--disable-Werror \
		--target=${CHOST} ${myconf} || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	einstall || die "Install failed"
	dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog \
		INSTALL NEWS README THANKS TODO
	docinto doc; cd doc
	dodoc API FAQ FAT USER.jp
}

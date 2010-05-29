# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-2.3.ebuild,v 1.1 2010/05/29 16:18:05 jer Exp $

EAPI="2"

inherit autotools eutils

DESCRIPTION="Create, destroy, resize, check, copy partitions and file systems"
HOMEPAGE="http://www.gnu.org/software/parted"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="nls readline +debug selinux device-mapper"

# specific version for gettext needed
# to fix bug 85999
DEPEND=">=sys-fs/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2
	nls? ( >=sys-devel/gettext-0.12.1-r2 )
	readline? ( >=sys-libs/readline-5.2 )
	selinux? ( sys-libs/libselinux )
	device-mapper? ( || (
		>=sys-fs/lvm2-2.02.45
		sys-fs/device-mapper )
	)"

src_prepare() {
	# The symlink test should SKIP instead of FAIL
	# when /dev/mapper is not found
	sed -i libparted/tests/Makefile.am \
		-e 's|t3000-symlink.sh||g' || die "sed failed"

	# The t6000-dm.sh test should equally SKIP instead of FAIL
	# when no dm support is present in the kernel
	sed -i tests/Makefile.am \
		-e '/t6000-dm.sh/d' || die "sed failed"

	eautoreconf
}

src_configure() {
	econf \
		$(use_with readline) \
		$(use_enable nls) \
		$(use_enable debug) \
		$(use_enable selinux) \
		$(use_enable device-mapper) \
		--disable-rpath \
		--disable-Werror || die "Configure failed"
}

src_test() {
	if use debug; then
		emake check || die "emake check failed"
	else
		ewarn "Skipping tests because USE=-debug is set."
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die "Install failed"
	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO
	dodoc doc/{API,FAT,USER.jp}
}

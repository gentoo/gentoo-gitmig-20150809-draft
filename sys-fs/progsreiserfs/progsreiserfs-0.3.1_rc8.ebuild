# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/progsreiserfs/progsreiserfs-0.3.1_rc8.ebuild,v 1.1 2005/01/10 02:10:30 vapier Exp $

inherit libtool flag-o-matic

MY_P=${PN}-${PV/_/-}
DESCRIPTION="library for accessing and manipulating reiserfs partitions"
HOMEPAGE="http://reiserfs.linux.kiev.ua/"
SRC_URI="http://reiserfs.linux.kiev.ua/snapshots/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc hppa amd64 alpha ia64 mips ppc64"
IUSE="nls debug"

RDEPEND=""
DEPEND="nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

src_compile() {
	elibtoolize
	filter-lfs-flags
	econf \
		--disable-Werror \
		$(use_enable nls) \
		$(use_enable debug) \
		|| die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	make install DESTDIR="${D}" || die "Install failed"
	# Make sure users only use the official namesys binaries
	rm -r "${D}"/usr/{sbin,share}

	dodoc AUTHORS BUGS ChangeLog NEWS README THANKS TODO
	docinto demos
	dodoc demos/*.c
}

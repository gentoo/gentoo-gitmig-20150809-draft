# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/testdisk/testdisk-6.8.ebuild,v 1.1 2007/08/14 11:50:09 dragonheart Exp $

inherit eutils flag-o-matic

DESCRIPTION="Multi-platform tool to check and undelete partition, supports reiserfs, ntfs, fat32, ext2/3 and many others. Also includes PhotoRec to recover pictures from digital camera memory."
HOMEPAGE="http://www.cgsecurity.org/wiki/TestDisk"
SRC_URI="http://www.cgsecurity.org/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="static reiserfs ntfs jpeg"
# WARNING: reiserfs support does NOT work with reiserfsprogs
# you MUST use progsreiserfs-0.3.1_rc8 (the last version ever released).
DEPEND=">=sys-libs/ncurses-5.2
		jpeg? ( media-libs/jpeg )
	  	ntfs? ( >=sys-fs/ntfsprogs-1.9.4 )
	  	reiserfs? ( >=sys-fs/progsreiserfs-0.3.1_rc8 )
	  	>=sys-fs/e2fsprogs-1.35"
RDEPEND="!static? ( ${DEPEND} )"

src_compile() {
	local myconf="--without-ewf"
	# --with-foo are broken, any use of --with/--without disable the
	# functionality.
	# The following variation must be used.
	use reiserfs || myconf="${myconf} --without-reiserfs"
	use ntfs || myconf="${myconf} --without-ntfs"
	use jpeg || myconf="${myconf} --without-jpeg"

	# this is static method is the same used by upstream for their 'static' make
	# target, but better, as it doesn't break.
	use static && append-ldflags -static

	econf ${myconf} || die

	# perform safety checks for NTFS and REISERFS
	if useq ntfs && egrep -q 'undef HAVE_LIBNTFS\>' ${S}/config.h ; then
		die "Failed to find NTFS library."
	fi
	if useq reiserfs && egrep -q 'undef HAVE_LIBREISERFS\>' ${S}/config.h ; then
		die "Failed to find reiserfs library."
	fi
	if useq jpeg && egrep -q 'undef HAVE_LIBJPEG\>' ${S}/config.h ; then
		die "Failed to find jpeg library."
	fi

	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	[ "$PF" != "$P" ] && mv ${D}/usr/share/doc/${P} ${D}/usr/share/doc/${PF}
}

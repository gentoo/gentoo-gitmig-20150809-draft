# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/linux-ntfs/linux-ntfs-1.6.0.ebuild,v 1.5 2004/06/30 17:11:18 vapier Exp $

inherit eutils

DESCRIPTION="Old userland utilities for NTFS filesystems (you should use ntfsprogs instead)"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

DEPEND=">=sys-devel/gcc-2.95"

src_unpack() {
	unpack ${A}
	cd ${S} || die
	epatch ${FILESDIR}/${P}-gcc3.2.patch
}

src_compile() {
	econf || die "econf failed"
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# lot's of docs (a good thing :)
	dodoc CREDITS ChangeLog NEWS README TODO.include TODO.mkntfs TODO.ntfsfix \
		doc/attribute_definitions doc/attributes.txt doc/compression.txt \
		doc/system_files.txt doc/system_security_descriptors.txt \
		doc/tunable_settings

	# a normal user cannot run ntfsfix
	cd ${D}
	mv usr/bin/ntfsfix usr/sbin
	rm -rf usr/bin
}

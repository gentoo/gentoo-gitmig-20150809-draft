# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/linux-ntfs/linux-ntfs-1.6.0.ebuild,v 1.4 2003/06/21 21:19:40 drobbins Exp $

DESCRIPTION="Utilities and library for accessing NTFS filesystems"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"

DEPEND=">=sys-devel/gcc-2.95"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64"

src_unpack() {
	unpack ${A}
	cd ${S} || die
	patch -p0 <${FILESDIR}/${P}-gcc3.2.patch || die
}

src_compile() {
	econf
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

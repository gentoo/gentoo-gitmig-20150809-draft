# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/linux-ntfs/linux-ntfs-1.6.0.ebuild,v 1.1 2002/11/02 07:51:43 woodchip Exp $

DESCRIPTION="Utilities and library for accessing NTFS filesystems"
HOMEPAGE="http://linux-ntfs.sourceforge.net/"

S=${WORKDIR}/${P}
SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV}.tar.gz"
DEPEND=">=sys-devel/gcc-2.96"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {
	unpack ${A} || die
	cd ${S} || die
	patch -p0 <${FILESDIR}/${P}-gcc3.2.patch || die
}

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	# a normal user cannot run ntfsfix
	cd ${D}
	mv usr/bin/ntfsfix usr/sbin
	rm -rf usr/bin
	cd ${S}

	# lot's of docs (a good thing :)
	dodoc CREDITS ChangeLog NEWS README TODO.include TODO.mkntfs TODO.ntfsfix \
		doc/attribute_definitions doc/attributes.txt doc/compression.txt \
		doc/system_files.txt doc/system_security_descriptors.txt \
		doc/tunable_settings
}

# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-arch/guitar/guitar-0.1.4.ebuild,v 1.5 2002/07/25 14:16:07 seemant Exp $


MY_P=guiTAR-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extraction tool, supports the tar, tar.Z, tar.gz, tar.bz2, lha,
lzh, rar, arj, zip, and slp formats."
SRC_URI="http://artemis.efes.net/disq/${PN}/${MY_P}.tar.gz"
HOMEPAGE="http://artemis.efes.net/disq/guitar/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="x11-libs/gtk+
	sys-apps/tar
	sys-apps/bzip2
	app-arch/rar
	app-arch/unrar
	sys-apps/gzip
	app-arch/zip
	app-arch/unzip"

src_compile() {

	local myconf

	use gnome || myconf="${myconf} --disable-gnome"

	econf ${myconf} || die
	emake || die
}

src_install() {
	
	use gnome && cp ${FILESDIR}/install.gnome ${S}
	einstall || die
}

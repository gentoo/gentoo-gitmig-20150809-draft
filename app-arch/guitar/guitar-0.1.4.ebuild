# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/guitar/guitar-0.1.4.ebuild,v 1.21 2004/03/12 11:11:06 mr_bones_ Exp $

MY_P=guiTAR-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extraction tool, supports the tar, tar.Z, tar.gz, tar.bz2, lha, lzh, rar, arj, zip, and slp formats."
SRC_URI="http://artemis.efes.net/disq/guitar/${MY_P}.tar.gz"
HOMEPAGE="http://artemis.efes.net/disq/guitar/"

IUSE="gnome"
SLOT="0"
LICENSE="GPL-2"

#app-arch/rar is binary for x86 only, how is sparc supported?
KEYWORDS="x86 ppc -sparc"

DEPEND="x11-libs/gtk+
	app-arch/tar
	app-arch/bzip2
	x86? ( app-arch/rar )
	app-arch/unrar
	app-arch/gzip
	app-arch/zip
	app-arch/unzip"

src_compile() {
	local myconf
	use gnome || myconf="${myconf} --disable-gnome"
	econf ${myconf}
	emake || die
}

src_install() {
	use gnome && cp ${FILESDIR}/install.gnome ${S}
	einstall
}

# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/guitar/guitar-0.1.4.ebuild,v 1.26 2004/11/17 16:56:08 vapier Exp $

MY_P=guiTAR-${PV}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extraction tool, supports tar, tar.Z, tar.gz, tar.bz2, lha, lzh, rar, arj, zip, and slp formats"
HOMEPAGE="http://artemis.efes.net/disq/guitar/"
SRC_URI="http://artemis.efes.net/disq/guitar/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc x86"
IUSE="gnome"

DEPEND="=x11-libs/gtk+-1.2*
	app-arch/tar
	app-arch/bzip2
	x86? ( app-arch/rar )
	app-arch/unrar
	app-arch/gzip
	app-arch/zip
	app-arch/unzip"

src_compile() {
	econf $(use_enable gnome) || die
	emake || die
}

src_install() {
	use gnome && cp ${FILESDIR}/install.gnome ${S}
	make install DESTDIR="${D}" || die
}

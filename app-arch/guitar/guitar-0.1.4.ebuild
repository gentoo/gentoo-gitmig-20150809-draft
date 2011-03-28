# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/guitar/guitar-0.1.4.ebuild,v 1.30 2011/03/28 14:51:37 angelos Exp $

EAPI=3
inherit eutils toolchain-funcs

MY_P=guiTAR-${PV}

DESCRIPTION="Extraction tool, supports tar, tar.Z, tar.gz, tar.bz2, lha, lzh, rar, arj, zip, and slp formats"
# No HOMEPAGE available. Debian has this left in oldstable.
HOMEPAGE="http://packages.debian.org/sarge/guitar"
SRC_URI="mirror://gentoo/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="x11-libs/gtk+:1"
RDEPEND="${DEPEND}
	app-arch/tar
	app-arch/bzip2
	app-arch/gzip
	app-arch/zip
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_configure() {
	econf --disable-gnome
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS BUGS NEWS README TODO
	newicon src/icon.xpm guiTAR.xpm
	make_desktop_entry ${PN} "Graphical User Interface for TAR" guiTAR
}

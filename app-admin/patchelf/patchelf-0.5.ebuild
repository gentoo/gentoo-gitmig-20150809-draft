# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/patchelf/patchelf-0.5.ebuild,v 1.1 2010/11/14 12:53:31 jlec Exp $

EAPI="3"

NUMBER="114505"

DESCRIPTION="Small utility to modify the dynamic linker and RPATH of ELF executables."
HOMEPAGE="http://nixos.org/patchelf.html"
SRC_URI="http://hydra.nixos.org/build/${NUMBER}/download/2/${P}.tar.bz2"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"
IUSE=""

src_configure() {
	econf \
		--docdir="${EPREFIX}"/usr/share/doc/${PF}
}

src_install() {
	emake DESTDIR="${D}" install || die
}

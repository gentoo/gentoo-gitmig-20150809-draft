# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/elfsh/elfsh-0.5_beta8.ebuild,v 1.1 2003/07/08 19:47:18 solar Exp $

IUSE=""

MY_PV=${PV/_beta/b}
S=${WORKDIR}/${PN}-${MY_PV}-linux

DESCRIPTION="ELFsh is an interactive and scriptable ELF machine to play with executable files, shared libraries and relocatable ELF32 objects"
HOMEPAGE="http://devhell.org/projects/elfsh"
SRC_URI="http://devhell.org/projects/elfsh/files/elfsh-${MY_PV}-linux.tgz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND="virtual/glibc
	>=dev-libs/expat-1.95
	>=sys-devel/gettext-0.11
"

RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PN}-${MY_PV}-linux.diff
}

src_compile() {
	cd ${S}
	# emacs does not have to be a requirement.
	emake ETAGS=echo || die "emake failed"
}

src_install() {
	cd ${S}
	einstall DESTDIR=${D} || die "einstall failed"
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-it/man-pages-it-0.3.4.ebuild,v 1.2 2006/02/08 04:07:46 vapier Exp $

DESCRIPTION="A somewhat comprehensive collection of Italian Linux man pages"
HOMEPAGE="http://it.tldp.org/man/"
SRC_URI="http://ftp.pluto.it/pub/pluto/ildp/man/${P}.tar.gz"

LICENSE="LDP-1a"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

S=${WORKDIR}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^ZIP/s:=.*:=:' \
		-e 's:X11R6/::' \
		-e '/mandir=/s:/man:/share/man:' \
		Makefile
}

src_compile() { :; }

src_install() {
	make install prefix="${D}"/usr || die
	dodoc CONTRIB NEW README* TODO
}

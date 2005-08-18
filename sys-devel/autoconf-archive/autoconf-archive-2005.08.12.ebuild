# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/autoconf-archive/autoconf-archive-2005.08.12.ebuild,v 1.1 2005/08/18 02:00:32 vapier Exp $

MY_PV=${PV//./-}
DESCRIPTION="GNU Autoconf Macro Archive"
HOMEPAGE="http://autoconf-archive.cryp.to/"
SRC_URI="http://autoconf-archive.cryp.to/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=""
RDEPEND="sys-devel/automake
	sys-devel/autoconf"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i \
		-e '/^htmldir/s:$(prefix)/html:$(datadir)/doc/'${PF}'/html:' \
		Makefile.in || die "sed html doc"
}

src_install() {
	make install DESTDIR="${D}" || die
	rm -r "${D}"/usr/share/${PN}
	dodoc AUTHORS README
}

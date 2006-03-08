# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.3.5.ebuild,v 1.7 2006/03/08 01:50:38 vapier Exp ${P}-r1.ebuild,v 1.8 2002/10/04 06:34:42 kloeri Exp $

inherit eutils libtool

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.3"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

DEPEND=">=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.8.3"
# the autoconf dep is due to it complaining 'configure.ac:55: error: Autoconf version 2.58 or higher is required'
# the automake dep is due to Bug #46037

src_unpack() {
	unpack ${A}
	cd "${S}"
	echo
	# Install updated missing script
	portageq has_version / "sys-devel/automake" && {
		rm -f missing
		automake --add-missing
	}

	elibtoolize
}

src_install() {
	cd libltdl
	make DESTDIR="${D}" install || die

	# basically we just install ABI libs for old packages
	rm -r "${D}"/usr/include
	rm -f "${D}"/usr/lib/libltdl.{a,la,so}
}

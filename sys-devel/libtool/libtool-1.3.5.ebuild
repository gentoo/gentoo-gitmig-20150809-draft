# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-1.3.5.ebuild,v 1.1 2004/11/09 16:33:04 vapier Exp ${P}-r1.ebuild,v 1.8 2002/10/04 06:34:42 kloeri Exp $

inherit eutils gnuconfig libtool

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/libtool.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1.3"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND="virtual/libc
	>=sys-devel/autoconf-2.58
	>=sys-devel/automake-1.8.3"
# the autoconf dep is due to it complaining 'configure.ac:55: error: Autoconf version 2.58 or higher is required'
# the automake dep is due to Bug #46037

lt_setup() {
	export WANT_AUTOCONF=2.5
	export WANT_AUTOMAKE=1.5
}

src_unpack() {
	lt_setup

	unpack ${A}

	cd ${S}
	echo
	# Install updated missing script
	portageq has_version / "sys-devel/automake" && {
		rm -f missing
		automake --add-missing
	}

	epatch ${FILESDIR}/1.4.3/${PN}-1.2f-cache.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.3.5-nonneg.patch
	epatch ${FILESDIR}/1.4.3/${PN}-1.3.5-mktemp.patch

	uclibctoolize
	gnuconfig_update ${WORKDIR}
}

src_compile() {
	lt_setup
	econf || die
	emake || die
}

src_install() {
	cd libltdl
	make DESTDIR=${D} install || die

	# basically we just install for old packages
	rm -r "${D}"/usr/include
	rm -f "${D}"/usr/lib/libltdl.{a,la,so}
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/libtool/libtool-2.2.2-r1.ebuild,v 1.1 2008/04/22 22:43:45 vapier Exp $

inherit eutils autotools

DESCRIPTION="A shared library tool for developers"
HOMEPAGE="http://www.gnu.org/software/libtool/"
SRC_URI="mirror://gnu/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="1.5"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="vanilla"

RDEPEND="sys-devel/gnuconfig
	>=sys-devel/autoconf-2.60
	>=sys-devel/automake-1.10"
DEPEND="${RDEPEND}
	sys-apps/help2man"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-flag-order.patch
	epatch "${FILESDIR}"/${P}-AC_LIBLTDL_CONVENIENCE.patch
	epatch "${FILESDIR}"/${P}-AC_ENABLE_SHARED.patch
	if ! use vanilla ; then
		epunt_cxx
		cd libltdl/m4
		epatch "${FILESDIR}"/1.5.20/${PN}-1.5.20-use-linux-version-in-fbsd.patch #109105
		cd "${S}"
	fi

	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog* NEWS README THANKS TODO doc/PLATFORMS

	local x
	for x in libtool libtoolize ; do
		help2man ${x} > ${x}.1
		doman ${x}.1 || die
	done

	for x in $(find "${D}" -name config.guess -o -name config.sub) ; do
		rm -f "${x}" ; ln -sf /usr/share/gnuconfig/${x##*/} "${x}"
	done
}

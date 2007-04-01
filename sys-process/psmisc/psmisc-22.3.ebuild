# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-process/psmisc/psmisc-22.3.ebuild,v 1.5 2007/04/01 10:06:25 hansmi Exp $

inherit eutils

DESCRIPTION="A set of tools that use the proc filesystem"
HOMEPAGE="http://psmisc.sourceforge.net/"
SRC_URI="mirror://sourceforge/psmisc/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ia64 m68k ~mips ppc ~ppc64 s390 sh sparc x86"
IUSE="ipv6 nls selinux X"

RDEPEND=">=sys-libs/ncurses-5.2-r2
	selinux? ( sys-libs/libselinux )"
DEPEND="${RDEPEND}
	sys-devel/libtool
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-22.2-gcc2.patch
}

src_compile() {
	econf \
		--bindir=/bin \
		$(use_enable selinux) \
		$(use_enable nls) \
		$(use_enable ipv6) \
		|| die
	emake || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog NEWS README

	# Some packages expect these to use /usr, others to use /
	dodir /usr/bin
	cd "${D}"/bin
	for f in * ; do
		dosym /bin/${f} /usr/bin/${f}
	done
	use X || find "${D}" -name pstree.x11 -exec rm {} \;
}

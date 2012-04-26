# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libelf/libelf-0.8.13-r1.ebuild,v 1.8 2012/04/26 14:06:14 aballier Exp $

EAPI=2
inherit eutils multilib autotools

DESCRIPTION="A ELF object file access library"
HOMEPAGE="http://www.mr511.de/software/"
SRC_URI="http://www.mr511.de/software/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ppc sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="debug nls elibc_FreeBSD"

RDEPEND="!dev-libs/elfutils"
DEPEND="nls? ( sys-devel/gettext )"

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch"
	eautoreconf

}

src_configure() {
	# prefix might want to play with this; unfortunately the stupid
	# macro used to detect whether we're building ELF is so screwed up
	# that trying to fix it is just a waste of time.
	export mr_cv_target_elf=yes

	econf \
		$(use_enable nls) \
		--enable-shared \
		$(use_enable debug)
}

src_install() {
	emake \
		prefix="${D}usr" \
		libdir="${D}usr/$(get_libdir)" \
		install \
		install-compat || die

	dodoc ChangeLog README || die

	# Stop libelf from stamping on the system nlist.h
	use elibc_FreeBSD && rm "${D}"/usr/include/nlist.h
}

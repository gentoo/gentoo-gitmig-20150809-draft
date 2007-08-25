# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.13.25.ebuild,v 1.3 2007/08/25 11:43:17 vapier Exp $

inherit eutils multilib

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SRC_URI="mirror://debian/pool/main/d/dpkg/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 arm ~hppa ~ia64 m68k ~ppc s390 sh sparc ~x86"
IUSE="bzip2 selinux zlib"

RDEPEND=">=dev-lang/perl-5.6.0
	>=sys-libs/ncurses-5.2-r7
	zlib? ( >=sys-libs/zlib-1.1.4 )
	bzip2? ( app-arch/bzip2 )"
DEPEND="${RDEPEND}
	app-text/po4a"

src_compile() {
	econf \
		$(use_with bzip2 bz2lib) \
		$(use_with selinux) \
		$(use_with zlib) \
		|| die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die
	rm "${D}"/usr/sbin/{install-info,start-stop-daemon}
	rm "${D}"/usr/share/man/man?/{install-info,start-stop-daemon}.?
	dodoc ChangeLog INSTALL THANKS TODO
	keepdir /usr/$(get_libdir)/db/methods/{mnt,floppy,disk}
	keepdir /usr/$(get_libdir)/db/{alternatives,info,methods,parts,updates}
}

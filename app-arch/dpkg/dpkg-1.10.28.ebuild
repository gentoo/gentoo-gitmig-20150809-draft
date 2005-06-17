# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dpkg/dpkg-1.10.28.ebuild,v 1.3 2005/06/17 01:02:55 vapier Exp $

inherit eutils

DESCRIPTION="Package maintenance system for Debian"
HOMEPAGE="http://packages.qa.debian.org/dpkg"
SRC_URI="mirror://debian/pool/main/d/dpkg/${P/-/_}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm ppc sparc x86"
IUSE="zlib bzip2"

RDEPEND=">=dev-lang/perl-5.6.0
	>=sys-libs/ncurses-5.2-r7
	zlib? ( >=sys-libs/zlib-1.1.4 )
	bzip2? ( app-arch/bzip2 )" #app-text/sgmltools-lite?
DEPEND="${RDEPEND}
	>=sys-devel/gettext-0.11.5"

src_unpack() {
	unpack ${A}
	cd "${S}"
	ln -s ../archtable main/archtable
	epatch "${FILESDIR}"/${PN}-1.10.26.patch
	epatch "${FILESDIR}"/${PN}-1.10.27.gcc4.patch
}

src_compile() {
	econf \
		$(use_with zlib) \
		$(use_with bzip2 bz2lib) \
		|| die
	make || die
}

src_install() {
	make DESTDIR="${D}" install || die
	rm -f "${D}"/usr/sbin/{install-info,start-stop-daemon}
	rm -f "${D}"/usr/bin/md5sum
	rm -f "${D}"/usr/share/man/man?/{md5sum,install-info,start-stop-daemon}.?
	dodoc ChangeLog INSTALL THANKS TODO
	keepdir /usr/lib/db/methods/{mnt,floppy,disk}
	keepdir /usr/lib/db/{alternatives,info,methods,parts,updates}
}

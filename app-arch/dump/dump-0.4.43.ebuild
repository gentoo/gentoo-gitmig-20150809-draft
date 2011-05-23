# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.43.ebuild,v 1.1 2011/05/23 08:01:26 pva Exp $

EAPI="4"
inherit eutils autotools

MY_P=${P/4./4b}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
HOMEPAGE="http://dump.sourceforge.net/"
SRC_URI="mirror://sourceforge/dump/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="debug ermt readline selinux static"

RDEPEND=">=sys-fs/e2fsprogs-1.27
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4
	ermt? ( dev-libs/openssl )
	readline? ( sys-libs/readline
		sys-libs/ncurses
		static? ( sys-libs/ncurses[static-libs] ) )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_prepare() {
	# https://sourceforge.net/tracker/?func=detail&aid=3306159&group_id=1306&atid=301306
	epatch "${FILESDIR}/dump-0.4b43-pkg_config4blkid.patch"
	epatch "${FILESDIR}/dump-0.4b43-pkg_config4ext2fs.patch"
	epatch "${FILESDIR}/dump-0.4b43-pkg_config4crypto.patch"
	eautoreconf
}

src_configure() {
	econf \
		--with-dumpdatespath=/etc/dumpdates \
		--with-{bin,man}owner=root \
		--with-{bin,man}grp=root \
		--enable-largefile \
		$(use_enable selinux transselinux) \
		$(use_enable ermt) \
		$(use_enable static) \
		$(use_enable readline) \
		$(use_enable debug)
}

src_install() {
	# built on old autotools, no DESTDIR support
	einstall MANDIR="${D}"/usr/share/man/man8
	mv "${ED}"/usr/sbin/{,dump-}rmt || die
	mv "${ED}"/usr/share/man/man8/{,dump-}rmt.8 || die
	use ermt && newsbin rmt/ermt dump-ermt

	dodoc CHANGES KNOWNBUGS MAINTAINERS README REPORTING-BUGS THANKS TODO
	dodoc -r examples/*
}

pkg_postinst() {
	ewarn "app-arch/dump installs 'rmt' as 'dump-rmt'."
	ewarn "This is to avoid conflicts with app-arch/tar 'rmt'."
}

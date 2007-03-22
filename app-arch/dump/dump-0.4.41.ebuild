# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/dump/dump-0.4.41.ebuild,v 1.3 2007/03/22 18:23:15 gustavoz Exp $

MY_P=${P/4./4b}
S=${WORKDIR}/${MY_P}
DESCRIPTION="Dump/restore ext2fs backup utilities"
HOMEPAGE="http://dump.sourceforge.net/"
SRC_URI="mirror://sourceforge/dump/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 sparc x86"
IUSE="readline static ermt"

RDEPEND=">=sys-fs/e2fsprogs-1.27
	>=app-arch/bzip2-1.0.2
	>=sys-libs/zlib-1.1.4
	ermt? ( dev-libs/openssl )
	readline? ( sys-libs/readline )"
DEPEND="${RDEPEND}
	virtual/os-headers"

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i "s:-ltermcap:-lncurses:g" configure || die
}

src_compile() {
	econf \
		--with-dumpdatespath=/etc/dumpdates \
		--with-{bin,man}owner=root \
		--with-{bin,man}grp=root \
		--enable-largefile \
		$(use_enable ermt) \
		$(use_enable static) \
		$(use_enable readline) \
		|| die
	emake || die
}

src_install() {
	# built on old autotools, no DESTDIR support
	einstall MANDIR="${D}"/usr/share/man/man8 || die
	mv "${D}"/usr/sbin/{,dump-}rmt
	mv "${D}"/usr/share/man/man8/{,dump-}rmt.8
	use ermt && newsbin rmt/ermt dump-ermt

	dodoc CHANGES KNOWNBUGS MAINTAINERS README REPORTING-BUGS THANKS TODO
	cd examples
	local d=
	for d in * ; do
		docinto ${d}
		dodoc ${d}/*
	done
}

pkg_postinst() {
	ewarn "app-arch/dump installs 'rmt' as 'dump-rmt'."
	ewarn "This is to avoid conflicts with app-arch/tar 'rmt'."
}

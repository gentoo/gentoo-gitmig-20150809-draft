# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ettercap/ettercap-0.7.0.ebuild,v 1.9 2004/11/04 12:59:57 eldad Exp $

# the actual version is "NG-0.7.0" but I suppose portage people will not be
# happy with it (as for the 0.6.b version), so let's set it to "0.7.0".
# since 'ettercap NG' has to be intended as an upgrade to 0.6.x serie and not as
# a new project or branch, this will be fine...

inherit flag-o-matic

MY_P=${PN}-NG-${PV}
S=${WORKDIR}/${MY_P}

DESCRIPTION="A suite for man in the middle attacks and network mapping"
HOMEPAGE="http://ettercap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 sparc ppc hppa"
IUSE="ssl ncurses gtk debug"

# libtool is needed because it provides libltdl (needed for plugins)
RDEPEND="virtual/libc
		 sys-libs/zlib
		 >=sys-devel/libtool-1.4.3
		 >=net-libs/libnet-1.1.2.1
		 >=net-libs/libpcap-0.8.1
		 ncurses? ( sys-libs/ncurses )
		 ssl? ( dev-libs/openssl )
		 gtk? ( >=x11-libs/gtk+-2.2.2 )"

DEPEND=">=sys-apps/sed-4.0.5
		>=sys-apps/portage-2.0.45-r3
		${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	sed -i 's:exec_prefix="/usr/local":exec_prefix="$prefix":' configure
}

src_compile() {
	strip-flags

	local myconf

	if use ssl; then
		myconf="${myconf} --with-openssl=/usr"
	else
		myconf="${myconf} --without-openssl"
	fi

	econf ${myconf} \
		`use_enable gtk gtk` \
		`use_enable debug debug` \
		`use_with ncurses ncurses` \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ettercap/ettercap-0.7.3-r1.ebuild,v 1.1 2006/12/09 11:20:09 drizzt Exp $

# the actual version is "NG-0.7.0" but I suppose portage people will not be
# happy with it (as for the 0.6.b version), so let's set it to "0.7.0".
# since 'ettercap NG' has to be intended as an upgrade to 0.6.x series and not as
# a new project or branch, this will be fine...

WANT_AUTOMAKE="1.8"

inherit flag-o-matic autotools

MY_P="${PN}-NG-${PV}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A suite for man in the middle attacks and network mapping"
HOMEPAGE="http://ettercap.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~sparc ~x86 ~x86-fbsd"
IUSE="ssl ncurses gtk debug"

# libtool is needed because it provides libltdl (needed for plugins)
RDEPEND=">=sys-devel/libtool-1.4.3
		 >=net-libs/libnet-1.1.2.1-r1
		 net-libs/libpcap
		 ncurses? ( sys-libs/ncurses )
		 ssl? ( dev-libs/openssl )
		 gtk? ( >=x11-libs/gtk+-2.2.2 )"

DEPEND=">=sys-apps/sed-4.0.5
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-as-needed.patch

	eautomake
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
		$(use_enable gtk) \
		$(use_enable debug) \
		$(use_with ncurses) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
}

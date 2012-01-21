# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-9999.ebuild,v 1.1 2012/01/21 17:22:14 slyfox Exp $

EAPI=4

if [[ ${PV} = *9999* ]]; then
	EGIT_REPO_URI="git://midnight-commander.org/git/mc.git"
	LIVE_ECLASSES="git-2 autotools"
	LIVE_EBUILD=yes
fi

inherit flag-o-matic ${LIVE_ECLASSES}

if [[ -n ${LIVE_EBUILD} ]]; then
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="http://www.midnight-commander.org/downloads/${P}.tar.xz"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
fi

DESCRIPTION="GNU Midnight Commander is a text based file manager"
HOMEPAGE="http://www.midnight-commander.org"

LICENSE="GPL-3"
SLOT="0"
IUSE="+edit gpm mclib +ncurses nls samba slang test X +xdg"

REQUIRED_USE="^^ ( ncurses slang )"

RDEPEND=">=dev-libs/glib-2.8:2
	gpm? ( sys-libs/gpm )
	kernel_linux? ( sys-fs/e2fsprogs )
	ncurses? ( sys-libs/ncurses )
	samba? ( net-fs/samba )
	slang? ( >=sys-libs/slang-2 )
	X? ( x11-libs/libX11
		x11-libs/libICE
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libSM )"
DEPEND="${RDEPEND}
	app-arch/xz-utils
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )
	test? ( dev-libs/check )
	"

[[ -n ${LIVE_EBUILD} ]] && DEPEND="${DEPEND} dev-vcs/cvs" # needed only for SCM source tree (autopoint uses cvs)

src_prepare() {
	[[ -n ${LIVE_EBUILD} ]] && ./autogen.sh
}

src_configure() {
	local myscreen=ncurses
	use slang && myscreen=slang
	[[ ${CHOST} == *-solaris* ]] && append-ldflags "-lnsl -lsocket"

	local homedir=".mc"
	use xdg && homedir="XDG"

	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--enable-vfs \
		$(use_enable kernel_linux vfs-undelfs) \
		--enable-charset \
		$(use_with X x) \
		$(use_enable samba vfs-smb) \
		$(use_with gpm gpm-mouse) \
		--with-screen=${myscreen} \
		$(use_with edit) \
		$(use_enable mclib) \
		$(use_enable test tests) \
		--with-homedir=${homedir}
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README NEWS

	# fix bug #334383
	if use kernel_linux && [[ ${EUID} == 0 ]] ; then
		fowners root:tty /usr/libexec/mc/cons.saver ||
			die "setting cons.saver's owner failed"
		fperms g+s /usr/libexec/mc/cons.saver ||
			die "setting cons.saver's permissions failed"
	fi
}

pkg_postinst() {
	elog "To enable exiting to latest working directory,"
	elog "put this into your ~/.bashrc:"
	elog ". ${EPREFIX}/usr/libexec/mc/mc.sh"
}

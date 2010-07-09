# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-4.7.3-r1.ebuild,v 1.1 2010/07/09 08:16:06 wired Exp $

EAPI=3

inherit base

MY_P=${P/_/-}

DESCRIPTION="GNU Midnight Commander is a text based file manager"
HOMEPAGE="http://www.midnight-commander.org"
SRC_URI="http://www.midnight-commander.org/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x86-solaris"
IUSE="+edit gpm nls samba slang X"

RDEPEND=">=dev-libs/glib-2.8:2
	gpm? ( sys-libs/gpm )
	kernel_linux? ( sys-fs/e2fsprogs )
	samba? ( net-fs/samba )
	slang? ( >=sys-libs/slang-2 )
	!slang? ( sys-libs/ncurses )
	X? ( x11-libs/libX11
		x11-libs/libICE
		x11-libs/libXau
		x11-libs/libXdmcp
		x11-libs/libSM )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

S=${WORKDIR}/${MY_P}

# bug #327573
PATCHES=(
	"${FILESDIR}/${P}_advanced_chown_segfault_fix.patch"
	"${FILESDIR}/${P}_mcedit_quit_dialog_default.patch"
)

src_configure() {
	local myscreen=ncurses
	use slang && myscreen=slang

	econf \
		--disable-dependency-tracking \
		$(use_enable nls) \
		--enable-vfs \
		$(use_enable kernel_linux vfs-undelfs) \
		--enable-charset \
		$(use_with X x) \
		$(use_with samba) \
		--with-configdir="${EPREFIX}"/etc/samba \
		--with-codepagedir="${EPREFIX}"/var/lib/samba/codepages \
		$(use_with gpm gpm-mouse) \
		--with-screen=${myscreen} \
		$(use_with edit)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README
}

pkg_postinst() {
	elog "To enable exiting to latest working directory,"
	elog "put this into your ~/.bashrc:"
	elog ". ${EPREFIX}/usr/libexec/mc/mc.sh"
}

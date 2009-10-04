# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/mc/mc-4.7.0_pre1.ebuild,v 1.20 2009/10/04 20:44:58 maekke Exp $

EAPI=2
inherit autotools eutils

MY_P=${P/_/-}

DESCRIPTION="GNU Midnight Commander is a text based file manager"
HOMEPAGE="http://www.midnight-commander.org"
SRC_URI="http://www.midnight-commander.org/downloads/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ~ia64 ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE="gpm nls samba +slang X"

RDEPEND=">=dev-libs/glib-2.6:2
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

src_prepare() {
	rm -f m4/{libtool,lt*}.m4 || die "libtool fix failed"
	epatch "${FILESDIR}"/${P}-ebuild_syntax.patch \
		"${FILESDIR}"/${P}-tbz2_filetype.patch \
		"${FILESDIR}"/${P}-undelfs_configure.patch
	AT_NO_RECURSIVE="yes" eautoreconf
}

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
		--with-configdir=/etc/samba \
		--with-codepagedir=/var/lib/samba/codepages \
		$(use_with gpm gpm-mouse) \
		--with-screen=${myscreen} \
		--with-edit
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README
}

pkg_postinst() {
	elog "To enable exiting to latest working directory,"
	elog "put this into your ~/.bashrc:"
	elog ". /usr/libexec/mc/mc.sh"
}

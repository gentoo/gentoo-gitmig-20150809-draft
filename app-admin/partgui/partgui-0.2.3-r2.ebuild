# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/partgui/partgui-0.2.3-r2.ebuild,v 1.13 2008/07/27 19:11:29 carlo Exp $

EAPI=1

inherit qt3

DESCRIPTION="PartGUI is a nice graphical partitioning tool"
HOMEPAGE="http://part-gui.sourceforge.net/"
SRC_URI="mirror://sourceforge/part-gui/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ppc x86"
IUSE=""

RDEPEND="x11-libs/qt:3
	dev-libs/newt
	>=sys-apps/parted-1.6.5
	>=sys-fs/xfsprogs-2.3.9
	>=sys-libs/slang-1.4
	>=sys-fs/e2fsprogs-1.33"

DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	x11-libs/libX11
	x11-libs/libXt"

src_compile() {
	# fix the sandbox errors "can't writ to .kde or .qt" problems.
	# this is a fake homedir that is writeable under the sandbox, so that the build process
	# can do anything it wants with it.
	REALHOME="$HOME"
	mkdir -p "${T}"/fakehome/.kde
	mkdir -p "${T}"/fakehome/.qt
	export HOME="${T}/fakehome"
	addwrite "${QTDIR}/etc/settings"
	# things that should access the real homedir
	[ -d "$REALHOME/.ccache" ] && ln -sf "$REALHOME/.ccache" "$HOME/"

	econf --disable-static || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	rm "${D}"/usr/sbin/run_partgui
	mv "${D}"/usr/sbin/piguicqt "${D}"/usr/sbin/partgui
	dodoc ChangeLog README THANKS TODO AUTHORS
}

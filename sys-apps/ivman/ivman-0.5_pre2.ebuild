# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

DESCRIPTION="Daemon to mount/unmount devices, based on info from HAL"
HOMEPAGE="http://ivman.sf.net"
SRC_URI="mirror://sourceforge/ivman/${P}.tar.bz2"
LICENSE="QPL"
KEYWORDS="~amd64 ~x86 ~ppc"
IUSE="debug"
SLOT="0"

RDEPEND=">=dev-libs/glib-2.2
	 dev-libs/libxml2
	 >=sys-apps/hal-0.2.98"
DEPEND="${RDEPEND}
	>=sys-devel/libtool-1.5
	dev-util/pkgconfig"

src_compile() {
	econf $(use_enable debug) || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	exeinto /etc/init.d/
	newexe ${FILESDIR}/ivman-0.3.init ivman
}

pkg_postinst() {
	einfo "Note that the configuration syntax has changed slightly from"
	einfo "previous versions.  If you are only using the default options,"
	einfo "just merge the new files with etc-update.  Otherwise, in your"
	einfo "existing rules, replace %m with \$hal.volume.mount_point\$ and"
	einfo "replace %d with \$hal.block.device\$.  Individual users may also"
	einfo "wish to remove their \${HOME}/.ivman directories and have default"
	einfo "files re-created with the new syntax."
}

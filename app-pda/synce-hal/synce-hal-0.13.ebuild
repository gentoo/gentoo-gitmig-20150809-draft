# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-pda/synce-hal/synce-hal-0.13.ebuild,v 1.4 2009/01/27 02:32:21 mescalinum Exp $

inherit multilib versionator

DESCRIPTION="SynCE - hal connection manager"
HOMEPAGE="http://sourceforge.net/projects/synce/"
LICENSE="MIT"

synce_PV=$(get_version_component_range 1-2)

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-apps/hal
		>=net-libs/gnet-2.0.0
		!app-pda/synce-dccm
		!app-pda/synce-vdccm
		!app-pda/synce-odccm
		=app-pda/synce-libsynce-${synce_PV}*
		=app-pda/synce-librapi2-${synce_PV}*
		=app-pda/synce-librra-${synce_PV}*"
RDEPEND="${DEPEND}
		=app-pda/synce-sync-engine-${synce_PV}*
		app-pda/synce-serial
		net-misc/dhcp"

SRC_URI="mirror://sourceforge/synce/${P}.tar.gz"

src_install() {
	make DESTDIR="${D}" install || die
	dodoc AUTHORS README ChangeLog || die

	# fix collision with app-pda/synce-serial, bug 246675
	rm -f "${D}/usr/libexec/synce-serial-chat"

	# fix install location of hal scripts
	local hal_dir="/usr/$(get_libdir)/hal"
	local hal_scripts_dir="${hal_dir}/scripts"
	dodir "${hal_scripts_dir}"
	mv "${D}${hal_dir}"/hal-synce-* "${D}${hal_scripts_dir}/"
}

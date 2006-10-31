# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_console/pam_console-0.99.6.2.3.6.ebuild,v 1.7 2006/10/31 00:36:33 metalgod Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit pam versionator rpm autotools

pv_fedora="$(get_version_component_range $(($(get_last_version_component_index)+1)) )"
pv_revision="$(get_version_component_range $(get_last_version_component_index) )"
pv_all_but_fedora="$(get_version_component_range 1-$(($(get_last_version_component_index)-1)) )"

MY_PV="${pv_all_but_fedora}-${pv_revision}.fc${pv_fedora}"

DESCRIPTION="pam_console module for PAM"
HOMEPAGE="http://cvs.fedora.redhat.com/viewcvs/devel/pam/"
SRC_URI="mirror://fedora/development/source/SRPMS/pam-${MY_PV}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-libs/pam-0.99"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

S="${WORKDIR}/modules/pam_console"

src_unpack() {
	rpm_src_unpack
	sed -e "s:@PV@:${MY_PV}:" "${FILESDIR}/${PN}-configure.ac" > "${S}/configure.ac"

	cd "${S}"
	eautoreconf
}

src_compile() {
	econf --libdir=/$(get_libdir) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc README
	exeinto /etc/dev.d/default
	doexec ${FILESDIR}/pam_console.dev
	insinto /etc/pam.d
	doins ${FILESDIR}/login
	doins ${FILESDIR}/gdm
	doins ${FILESDIR}/gdm-autologin
}

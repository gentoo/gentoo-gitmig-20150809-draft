# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/pam_console/pam_console-0.99.7.0.2.7.ebuild,v 1.6 2007/03/26 15:43:58 armin76 Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit pam versionator rpm autotools flag-o-matic

pv_fedora="$(get_version_component_range $(($(get_last_version_component_index)+1)) )"
pv_revision="$(get_version_component_range $(get_last_version_component_index) )"
pv_all_but_fedora="$(get_version_component_range 1-$(($(get_last_version_component_index)-1)) )"

MY_PV="${pv_all_but_fedora}-${pv_revision}.fc${pv_fedora}"

DESCRIPTION="pam_console module for PAM"
HOMEPAGE="http://cvs.fedora.redhat.com/viewcvs/devel/pam/"
SRC_URI="mirror://fedora/development/source/SRPMS/pam-${MY_PV}.src.rpm"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-libs/pam-0.99
	=dev-libs/glib-2*"
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
	# I don't care enough to go fixing RedHat's code
	append-flags -fno-strict-aliasing

	econf --libdir=/$(get_libdir) || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	dodoc README
	exeinto /etc/dev.d/default
	doexec "${FILESDIR}/pam_console.dev"
	insinto /etc/pam.d
	doins "${FILESDIR}/login"
	doins "${FILESDIR}/gdm"
	doins "${FILESDIR}/gdm-autologin"
}

pkg_postinst() {
	ewarn "${CATEGORY}/${PN} is provided without any warranty on its"
	ewarn "working state out of the box."
	ewarn "Please don't report default permission problems to Gentoo"
	ewarn "bugzilla, as Gentoo developers are not responsible for them."
}

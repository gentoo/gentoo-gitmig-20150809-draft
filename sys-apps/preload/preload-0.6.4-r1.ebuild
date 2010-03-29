# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/preload/preload-0.6.4-r1.ebuild,v 1.2 2010/03/29 15:40:17 pacho Exp $

inherit eutils autotools

DESCRIPTION="Adaptive readahead daemon."
HOMEPAGE="http://sourceforge.net/projects/preload/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vanilla"

WANT_AUTOCONF="2.56"

RDEPEND=">=dev-libs/glib-2.6"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/00-patch-configure.diff
	epatch "${FILESDIR}"/02-patch-preload_conf.diff
	epatch "${FILESDIR}"/02-patch-preload_sysconfig.diff
	use vanilla || epatch "${FILESDIR}"/000{1,2,3}-*.patch
	cat "${FILESDIR}"/preload-0.6.4.init.in > preload.init.in || die

	eautoreconf
}

src_compile() {
	econf --localstatedir=/var
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	# Remove log and state file from image or they will be
	# truncated during merge
	rm "${D}"/var/lib/preload/preload.state || die "cleanup failed"
	rm "${D}"/var/log/preload.log || die "cleanup failed"
	keepdir /var/lib/preload
	keepdir /var/log
}

pkg_postinst() {
	einfo "You probably want to add preload to the boot runlevel like so:"
	einfo "# rc-update add preload boot"
	echo
	eerror "IMPORTANT: If you are upgrading from preload < 0.6 ensure to"
	eerror "merge your config files (etc-update) or system performance"
	eerror "may suffer."
	echo
}

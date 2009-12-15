# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/915resolution/915resolution-0.5.3-r2.ebuild,v 1.4 2009/12/15 19:23:37 ssuominen Exp $

inherit eutils flag-o-matic

DESCRIPTION="Utility to patch VBIOS of Intel 855 / 865 / 915 chipsets"
HOMEPAGE="http://915resolution.mango-lang.org/"
SRC_URI="mirror://gentoo/${P}.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-freebsd.patch"

	# add support for 965GM (bug #186661)
	epatch "${FILESDIR}/${P}-965GM.patch"
}

src_compile() {
	filter-flags -O*
	emake clean
	emake CFLAGS="${CFLAGS}" || die "Compiliation failed."
}

src_install() {
	dosbin ${PN}
	newconfd "${FILESDIR}/confd" ${PN}
	newinitd "${FILESDIR}/initd-r1" ${PN}
	dodoc README.txt changes.log chipset_info.txt dump_bios
}

pkg_postinst() {
	elog
	elog "${PN} alters your video BIOS in a non-permanent way, this means"
	elog "that there is no risk of permanent damage to your video card, but"
	elog "it also means that it must be run at every boot. To set it up, "
	elog "edit /etc/conf.d/${PN} to add your configuration and type the"
	elog "following command to add it the your defautl runlevel:"
	elog
	elog "    \"rc-update add ${PN} default\""
	elog
}

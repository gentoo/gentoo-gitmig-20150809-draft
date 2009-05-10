# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/xsupplicant/xsupplicant-1.2.2.ebuild,v 1.5 2009/05/10 08:35:42 volkmar Exp $

inherit flag-o-matic

DESCRIPTION="Open Source Implementation of IEEE 802.1x"
HOMEPAGE="http://open1x.sourceforge.net/"
SRC_URI="mirror://sourceforge/open1x/${P}.tar.gz"

LICENSE="|| ( GPL-2 BSD )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

IUSE="eap-sim"

RDEPEND=">=dev-libs/openssl-0.9.7
		net-wireless/wireless-tools
		eap-sim? ( sys-apps/pcsc-lite )"
DEPEND="sys-devel/bison
		sys-devel/flex
		${RDEPEND}"

src_compile() {
	local conf

	# fix compilation with recent kernels
	append-flags -DHEADERS_KERNEL

	if use eap-sim; then
		# fix USE=-eap-sim (bug #118885)
		conf="--enable-eap-sim"
		# fix compilation with pcsc-lite-1.2.9_beta9 (bug #81338)
		append-flags -I/usr/include/PCSC
	fi

	econf \
		${conf} \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc AUTHORS README TODO \
		doc/README.certificates doc/README.wpa

	dohtml doc/Xsupplicant-wireless-cards.html

	docinto examples
	dodoc etc/*-example.conf

	insinto /etc
	newins etc/xsupplicant.conf xsupplicant.conf.example

	newconfd "${FILESDIR}"/${P}-conf.d ${PN}
	newinitd "${FILESDIR}"/${P}-init.d ${PN}
}

pkg_postinst() {
	einfo
	einfo "To use ${P} you must create the configuration file"
	einfo "/etc/xsupplicant.conf"
	einfo
	einfo "An example configuration file has been installed as"
	einfo "/etc/xsupplicant.conf.example"
	einfo
}

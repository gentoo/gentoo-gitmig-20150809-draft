# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/asterisk-app_icd/asterisk-app_icd-1.0.0.ebuild,v 1.8 2010/10/28 09:49:41 ssuominen Exp $

EAPI=2
inherit eutils

MY_PN="icd"

DESCRIPTION="ICD (Intelligent Call Distributor) application plugin for Asterisk"
HOMEPAGE="http://icd.sourceforge.net/"
SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE="debug"

RDEPEND=">=net-misc/asterisk-1.0.7-r1
	>=net-misc/zaptel-1.0.7-r1
	!>=net-misc/asterisk-1.2.0"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${MY_PN}-${PV}

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff

	# asterisk + bristuff
	if has_version net-misc/asterisk[bri]; then
		epatch "${FILESDIR}"/${P}-bristuff.diff
	fi

	# fix segfault in config parser (patch sent upstream)
	epatch "${FILESDIR}"/${P}-configsegv.diff
}

src_compile() {
	local myconf

	use debug && \
		myconf="${myconf} DEBUG=1"

	emake CFLAGS="${CFLAGS}" \
		.sqlite || die "Building sqlite failed"

	emake \
		${myconf} || die "emake failed"
}

src_install() {
	make INSTALL_PREFIX="${D}" install || die

	insinto /etc/asterisk
	newins  icd_config/extensions.conf.sample extensions.conf.icd

	chmod -R 750 "${D}"/etc/asterisk
	chown -R root:asterisk "${D}"/etc/asterisk

	dodoc README README.memory BUGS *.txt
}

pkg_postinst() {
	einfo "An example dialplan config for asterisk has been installed into:"
	einfo "   ${ROOT}/etc/asterisk/extensions.conf.icd"
	einfo ""
	einfo "See http://icd.sourceforge.net/ for more information"
}

# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/ddclient/ddclient-3.7.0.ebuild,v 1.3 2007/02/11 10:29:33 vapier Exp $

inherit eutils

DESCRIPTION="Perl updater client for dynamic DNS services"
HOMEPAGE="http://ddclient.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/perl-5.1
	dev-perl/IO-Socket-SSL"

pkg_setup() {
	enewgroup ${PN}
	enewuser ${PN} -1 -1 /dev/null ${PN}
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-reasonable-security.patch

	sed -i ${PN} \
		-e 's:$etc$program.cache:/var/cache/ddclient/$program.cache:' \
		|| die "sed ${PN} failed"

	# Remove pid line, because it is specified in /etc/conf.d/ddclient
	sed -i sample-etc_${PN}.conf \
		-e "/^pid=*/d" \
		|| die "sed sample failed"
}

src_install() {
	dosbin ${PN} || die "dosbin failed"
	dodoc README* Change* COPYRIGHT sample*

	newinitd "${FILESDIR}"/${PN}.initd ${PN} || die "newinitd failed"

	# Filename of sample conf - use live filename if available
	local sample=${PN}.conf
	[[ -e "${ROOT}/etc/${PN}/${sample}" ]] && sample="${sample}.sample"

	insinto /etc/${PN}
	insopts -m 0640 -o root -g ${PN}
	newins sample-etc_${PN}.conf "${sample}" || die "newins conf failed"

	insinto /etc/conf.d
	insopts -m 0644 -o root -g root
	newins "${FILESDIR}"/${PN}.confd ${PN} || die "newins confd failed"

	diropts -m 0755 -o ${PN} -g ${PN}
	keepdir /var/{cache,run}/${PN}
}

# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-dns/dnsmasq/dnsmasq-2.33.ebuild,v 1.2 2006/09/13 04:39:52 avenj Exp $

inherit eutils toolchain-funcs

MY_P="${P/_/}"
MY_PV="${PV/_rc*/}"
DESCRIPTION="Small forwarding DNS server"
HOMEPAGE="http://www.thekelleys.org.uk/dnsmasq/"
SRC_URI="http://www.thekelleys.org.uk/dnsmasq/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~s390 ~sh ~sparc ~x86"
IUSE="resolvconf"

RDEPEND=""
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51
	resolvconf? ( net-dns/resolvconf-gentoo )"

S=${WORKDIR}/${PN}-${MY_PV}

src_unpack() {
	unpack ${A}
	cd ${S}
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	make \
		PREFIX=/usr \
		MANDIR=/usr/share/man \
		DESTDIR="${D}" \
		install || die
	dodoc CHANGELOG FAQ
	dohtml *.html

	newinitd "${FILESDIR}"/dnsmasq-init dnsmasq
	newconfd "${FILESDIR}"/dnsmasq.confd dnsmasq
	insinto /etc
	newins dnsmasq.conf.example dnsmasq.conf

	if use resolvconf ; then
		insinto /etc/resolvconf/update.d
		newins ${FILESDIR}/resolvconf.dnsmasq dnsmasq
	fi
}

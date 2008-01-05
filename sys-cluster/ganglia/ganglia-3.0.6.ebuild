# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ganglia/ganglia-3.0.6.ebuild,v 1.1 2008/01/05 01:34:19 jsbronder Exp $

DESCRIPTION="Ganglia is a scalable distributed monitoring system for high-performance computing systems such as clusters and grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
SRC_URI="mirror://sourceforge/ganglia/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
IUSE="test minimal"

DEPEND="!minimal? ( net-analyzer/rrdtool )
	test? ( >=dev-libs/check-0.8.2 )"
RDEPEND="!minimal? ( net-analyzer/rrdtool )"

src_compile() {
	econf \
		--enable-gexec \
		$(use_with !minimal gmetad) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /etc
	doman mans/{gmetric.1,gmond.1,gstat.1}
	doman gmond/gmond.conf.5
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	newinitd "${FILESDIR}"/gmond.rc gmond

	if ! use minimal; then
		doins gmetad/gmetad.conf
		doman mans/gmetad.1
		keepdir /var/lib/ganglia/rrds
		fowners nobody:nobody /var/lib/ganglia/rrds
		newinitd "${FILESDIR}"/gmetad.rc gmetad
		insinto /usr/share/${PN}/
		doins -r web
	fi
}

pkg_postinst() {
	elog
	elog "This package doesn't include a configuration file for gmond."
	elog "You could generate a default template by running:"
	elog "    /usr/sbin/gmond -t > /etc/gmond.conf"
	elog "and customize it from there or provide your own."

	if ! use minimal; then
		elog
		elog "All the files necessary for the PHP frontend have been installed"
		elog "into ${ROOT}usr/share/${PN}/web/."
	fi
}

# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ganglia/ganglia-3.0.7.ebuild,v 1.4 2008/03/28 22:47:32 mr_bones_ Exp $

WEBAPP_OPTIONAL="yes"
inherit webapp depend.php

DESCRIPTION="Ganglia is a scalable distributed monitoring system for high-performance computing systems such as clusters and grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
SRC_URI="mirror://sourceforge/ganglia/${P}.tar.gz"
LICENSE="BSD"

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test minimal vhosts"

RDEPEND="!minimal? ( net-analyzer/rrdtool
	${WEBAPP_DEPEND}
	=virtual/httpd-php-5* )"
DEPEND="${RDEPEND}
	test? ( >=dev-libs/check-0.8.2 )"

pkg_setup() {
	if ! use minimal ; then
		require_gd
		require_php_with_use xml ctype
		webapp_pkg_setup
	fi
}

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

		webapp_src_preinst
		insinto "${MY_HTDOCSDIR}"
		doins -r web/*

		webapp_configfile "${MY_HTDOCSDIR}"/conf.php
		webapp_src_install
	fi
}

pkg_postinst() {
	elog
	elog "This package doesn't include a configuration file for gmond."
	elog "You could generate a default template by running:"
	elog "    /usr/sbin/gmond -t > /etc/gmond.conf"
	elog "and customize it from there or provide your own."

	use minimal || webapp_pkg_postinst
}

pkg_prerm() {
	use minimal || webapp_pkg_prerm
}

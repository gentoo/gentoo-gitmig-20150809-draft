# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ganglia/ganglia-3.1.0-r1.ebuild,v 1.2 2008/08/31 17:38:52 jsbronder Exp $

WEBAPP_OPTIONAL="yes"
inherit multilib webapp depend.php python

DESCRIPTION="A scalable distributed monitoring system for clusters and grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
SRC_URI="mirror://sourceforge/ganglia/${P}.tar.gz"
LICENSE="BSD"

WEBAPP_MANUAL_SLOT="yes"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="minimal vhosts python"

DEPEND="
	dev-libs/confuse
	dev-libs/expat
	>=dev-libs/apr-1.0
	python? ( >=dev-lang/python-2.3 )"

RDEPEND="
	${DEPEND}
	!minimal? ( net-analyzer/rrdtool
		${WEBAPP_DEPEND}
		=virtual/httpd-php-5* )"

pkg_setup() {
	if ! use minimal ; then
		require_gd
		require_php_with_use xml ctype
		webapp_pkg_setup
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/ganglia-3.1-gmond-python-tcpconn-concurrency.patch
	epatch "${FILESDIR}"/${P}-gmetad-hierarchical.patch
}

src_compile() {
	econf \
		--enable-gexec \
		$(use_enable python) \
		$(use_with !minimal gmetad) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/gmond.rc gmond
	doman mans/{gmetric.1,gmond.1,gstat.1}
	doman gmond/gmond.conf.5
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	dodir /etc/ganglia/conf.d
	gmond/gmond -t > "${D}"/etc/ganglia/gmond.conf

	if use python; then
		# Sadly, there is no install target for any of this.
		mv gmond/modules/python/README "${T}"/README.python_modules
		dodoc "${T}"/README.python_modules
		insinto /etc/ganglia/conf.d
		# multidisk/diskusage python metric skipped until fixed for gentoo
		doins gmond/modules/conf.d/modpython.conf
		doins gmond/python_modules/conf.d/tcpconn.pyconf
		dodir /usr/$(get_libdir)/ganglia/python_modules
		insinto /usr/$(get_libdir)/ganglia/python_modules
		doins gmond/python_modules/network/tcpconn.py
	fi

	insinto /etc/ganglia
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

pkg_preinst() {
	if has_version '<sys-cluster/ganglia-3.1.0'; then
		elog "Previous ganglia installation detected."
		elog "Copying gmetad configuration to /etc/ganglia"
		elog "You may have to remove /etc/gmond.conf yourself."
		mkdir -p "${D}"/etc/ganglia
		[ -f "${ROOT}"etc/gmetad.conf ] \
			&& cp "${ROOT}"etc/gmetad.conf "${D}"/etc/ganglia
	fi
}

pkg_postinst() {
	elog "A default configuration file for gmond has been generated"
	elog "for you as a template by running:"
	elog "    /usr/sbin/gmond -t > /etc/ganglia/gmond.conf"
	elog "customize it from there or provide your own but be aware"
	elog "the format has changed since 3.0 and so you won't be able"
	elog "to use your current configuration (if you generated any)"
	elog "in /etc/gmond.conf directly"

	use minimal || webapp_pkg_postinst

	use python && \
		python_mod_optimize /usr/$(get_libdir)/ganglia/python_modules/
}

pkg_prerm() {
	use minimal || webapp_pkg_prerm
}

pkg_postrm() {
	use python && \
		python_mod_cleanup /usr/$(get_libdir)/ganglia/python_modules/
	[ -d /usr/$(get_libdir)/ganglia ] && \
		rmdir /usr/$(get_libdir)/ganglia 2>/dev/null
}

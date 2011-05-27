# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-cluster/ganglia/ganglia-3.1.7-r2.ebuild,v 1.4 2011/05/27 11:49:15 phajdan.jr Exp $

EAPI="3"
WEBAPP_OPTIONAL="yes"

PYTHON_DEPEND="python? 2"
WEBAPP_MANUAL_SLOT="yes"

inherit eutils multilib webapp python

DESCRIPTION="A scalable distributed monitoring system for clusters and grids"
HOMEPAGE="http://ganglia.sourceforge.net/"
SRC_URI="mirror://sourceforge/ganglia/${P}.tar.gz"
LICENSE="BSD"

SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE="minimal vhosts python examples"

DEPEND="
	dev-libs/confuse
	dev-libs/expat
	>=dev-libs/apr-1.0
	!dev-db/firebird"

RDEPEND="
	${DEPEND}
	!minimal? ( net-analyzer/rrdtool
		${WEBAPP_DEPEND}
		dev-lang/php[gd,xml,ctype,cgi]
		|| ( <dev-lang/php-5.3[pcre] >=dev-lang/php-5.3 )
		media-fonts/dejavu
	)"

pkg_setup() {
	if use python; then
		python_set_active_version 2
		python_pkg_setup
	fi
	use minimal || webapp_pkg_setup
}

src_prepare() {
	# This patch just gives a group to the disk statistics.
	# I.E. it's just cosmetics
	epatch "${FILESDIR}"/${PN}-3.1.1-multidisk-group.patch

	# Disable modpython by default (#358359)
	sed -i '/ *params/N;s,\( *\)\(params = "[^"]*"\),\1\2\n\1enabled = no,' \
		gmond/modules/conf.d/modpython.conf.in || die
}

src_configure() {
	econf \
		--enable-gexec \
		--sysconfdir="${EPREFIX}"/etc/${PN} \
		$(use_enable python) \
		$(use_with !minimal gmetad) || die "econf failed"
}

src_install() {
	local exdir=/usr/share/doc/${P}

	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}"/gmond.rc-2 gmond
	doman {mans/*.1,gmond/*.5} || die "Failed to install manpages"
	dodoc AUTHORS ChangeLog INSTALL NEWS README || die

	dodir /etc/ganglia/conf.d
	use python && dodir /usr/$(get_libdir)/ganglia/python_modules
	gmond/gmond -t > "${ED}"/etc/ganglia/gmond.conf

	if use examples; then
		insinto ${exdir}/cmod-examples
		doins gmond/modules/example/*.c
		if use python; then
			# Installing as an examples per upstream.
			insinto ${exdir}/pymod-examples
			doins gmond/python_modules/*/*.py
			insinto ${exdir}/pymod-examples/conf.d
			doins gmond/python_modules/conf.d/*.pyconf
		fi
	fi

	if ! use minimal; then
		webapp_src_preinst
		insinto "${MY_HTDOCSDIR}"
		doins -r web/*
		webapp_configfile "${MY_HTDOCSDIR}"/conf.php
		webapp_src_install

		# webapp_src_install stomps on permissions, so do that
		# stuff first.
		insinto /etc/ganglia
		doins gmetad/gmetad.conf
		doman mans/gmetad.1

		newinitd "${FILESDIR}"/gmetad.rc-2 gmetad
		keepdir /var/lib/ganglia/rrds
		fowners nobody:nobody /var/lib/ganglia/rrds
	fi
}

pkg_postinst() {
	elog "A default configuration file for gmond has been generated"
	elog "for you as a template by running:"
	elog "    /usr/sbin/gmond -t > /etc/ganglia/gmond.conf"

	use minimal || webapp_pkg_postinst
}

pkg_prerm() {
	use minimal || webapp_pkg_prerm
}

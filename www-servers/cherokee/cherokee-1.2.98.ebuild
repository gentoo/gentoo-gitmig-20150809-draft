# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-1.2.98.ebuild,v 1.1 2011/08/26 11:58:08 matsuu Exp $

EAPI="3"
PYTHON_DEPEND="admin? 2"
PYTHON_USE_WITH="threads"

inherit eutils multilib pam python versionator

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="http://www.cherokee-project.com/download/$(get_version_component_range 1-2)/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.cherokee-project.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="admin coverpage ffmpeg debug geoip ipv6 kernel_linux ldap mysql nls pam php rrdtool ssl static static-libs"

COMMON_DEPEND="dev-libs/libpcre
	>=sys-libs/zlib-1.1.4-r1
	ffmpeg? ( virtual/ffmpeg )
	geoip? ( dev-libs/geoip )
	ldap? ( net-nds/openldap )
	mysql? ( >=virtual/mysql-5 )
	nls? ( virtual/libintl )
	pam? ( virtual/pam )
	php? ( || (
		dev-lang/php[fpm]
		dev-lang/php[cgi]
	) )
	ssl? ( dev-libs/openssl )"
DEPEND="${COMMON_DEPEND}
	nls? ( sys-devel/gettext )"
RDEPEND="${COMMON_DEPEND}
	rrdtool? ( net-analyzer/rrdtool )"

RESTRICT="test"

pkg_setup() {
	python_pkg_setup

	python_set_active_version 2

	enewgroup cherokee
	enewuser cherokee -1 -1 /var/www cherokee
}

src_prepare() {
	epatch \
		"${FILESDIR}/${P}-gentoo.patch" \
		"${FILESDIR}/${P}-linux3.patch"

	python_convert_shebangs -r 2 .
}

src_configure() {
	local myconf

	if use admin ; then
		myconf="${myconf} --enable-admin --with-python=$(PYTHON -2)"
	else
		myconf="${myconf} --disable-admin --without-python"
	fi

	# Uses autodetect because --with-php requires path to php-{fpm,cgi}.
	if ! use php ; then
		myconf="${myconf} --without-php"
	fi

	if use static ; then
		myconf="${myconf} --enable-static-module=all"
	fi

	local os="Unknown"
	case "${CHOST}" in
		*-freebsd*)
			os="FreeBSD" ;;
		*-netbsd*)
			os="NetBSD" ;;
		*-openbsd*)
			os="OpenBSD" ;;
		*)
			os="Linux" ;;
	esac

	# This make cherokee 1.2 sad
	#	$(use_enable threads pthread) \
	econf \
		$(use_enable debug trace) \
		$(use_enable debug backtraces) \
		$(use_enable ipv6) \
		$(use_enable kernel_linux epoll) \
		$(use_enable nls) \
		$(use_enable pam) \
		$(use_enable static-libs static) \
		$(use_with ffmpeg) \
		$(use_with geoip) \
		$(use_with ldap) \
		$(use_with mysql) \
		$(use_with ssl libssl) \
		--disable-dependency-tracking \
		--docdir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--enable-os-string="Gentoo ${os}" \
		--enable-tmpdir="${EPREFIX}/var/tmp" \
		--localstatedir="${EPREFIX}/var" \
		--with-wwwroot="${EPREFIX}/var/www/localhost/htdocs" \
		--with-cgiroot="${EPREFIX}/var/www/localhost/cgi-bin" \
		--with-wwwuser=cherokee \
		--with-wwwgroup=cherokee \
		${myconf} || die "configure failed"
}

src_test() {
	emake test || die
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"

	if ! use static-libs ; then
		find "${ED}" -name '*.la' -delete || die
	elif ! use static ; then
		find "${ED}/usr/$(get_libdir)/cherokee" '(' -name '*.la' -o -name '*.a' ')' -delete || die
	fi

	dodoc AUTHORS ChangeLog README || die

	use pam && pamd_mimic system-auth cherokee auth account session

	newinitd "${FILESDIR}/${PN}-initd-${PV}" ${PN} || die "newinitd ${PN} failed"
	newconfd "${FILESDIR}/${PN}-confd-${PV}" ${PN} || die "newconfd ${PN} failed"

	if ! use admin ; then
		rm -r \
			"${ED}"/usr/bin/cherokee-admin-launcher \
			"${ED}"/usr/bin/CTK-run \
			"${ED}"/usr/sbin/cherokee-admin \
			"${ED}"/usr/share/cherokee/admin
	fi

	exeinto /usr/share/doc/${PF}/contrib
	doexe contrib/{bin2buffer.py,make-cert.sh,make-dh_params.sh,tracelor.py}

	keepdir /var/www/localhost/htdocs /var/log/cherokee
	fowners cherokee:cherokee /var/log/cherokee

	if ! use coverpage ; then
		rm -rf "${ED}"/var/www/localhost/htdocs/*
	fi
}

pkg_postinst() {
	if use admin ; then
		python_mod_optimize "${EPREFIX}/usr/share/cherokee/admin/"
		echo
		elog "Just run '/usr/sbin/cherokee-admin' and go to: http://localhost:9090"
		echo
	else
		echo
		elog "Try USE=admin if you want an easy way to configure cherokee."
		echo
	fi
	elog "emerge www-servers/spawn-fcgi if you use Ruby on Rails with ${PN}."
	echo
}

pkg_postrm() {
	if use admin ; then
		python_mod_cleanup "${EPREFIX}/usr/share/cherokee/admin/"
	fi
}

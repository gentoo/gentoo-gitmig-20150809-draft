# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/cherokee/cherokee-0.8.1.ebuild,v 1.1 2008/09/02 19:58:52 bass Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit eutils pam versionator libtool autotools

DESCRIPTION="An extremely fast and tiny web server."
SRC_URI="http://www.cherokee-project.com/download/$(get_version_component_range 1-2)/${PV}/${P}.tar.gz"
HOMEPAGE="http://www.cherokee-project.com/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="ipv6 ssl gnutls static pam coverpage threads kernel_linux admin"

RDEPEND=">=sys-libs/zlib-1.1.4-r1
	ssl? (
		gnutls? ( net-libs/gnutls )
		!gnutls? ( dev-libs/openssl )
	)
	pam? ( virtual/pam )
	admin? ( dev-lang/python )"
DEPEND="${RDEPEND}"

src_compile() {
	local myconf

	if use ssl && use gnutls ; then
		myconf="${myconf} --enable-tls=gnutls"
	elif use ssl && ! use gnutls ; then
		myconf="${myconf}  --enable-tls=openssl"
	else
		myconf="${myconf} --disable-tls"
	fi

	if use static ; then
		myconf="${myconf} --enable-static --enable-static-module=all"
	else
		myconf="${myconf} --disable-static"
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

	econf \
		${myconf} \
		$(use_enable pam) \
		$(use_enable ipv6) \
		$(use_enable threads pthread) \
		$(use_enable kernel_linux epoll) \
		--disable-dependency-tracking \
		--enable-os-string="Gentoo ${os}" \
		--with-wwwroot=/var/www/localhost/htdocs \
		--prefix=/usr \
		--sysconfdir=/etc \
		--localstatedir=/var \
		|| die "configure failed"

	emake || die "emake failed"
}

src_install () {
	emake -j1 DESTDIR="${D}" docdir="/usr/share/doc/${PF}/html" install || die "make install failed"
	dodoc AUTHORS ChangeLog TODO

	newpamd pam.d_cherokee ${PN} || die "newpamd failed"
	newinitd "${FILESDIR}/${PN}-initd-0.6" ${PN} || die "newinitd failed"

	dodir /usr/share/doc/${PF}/contrib
	insinto /usr/share/${PF}/contrib
	doins contrib/05to06.py
	doins contrib/06to07.py

	keepdir /etc/cherokee/mods-enabled /etc/cherokee/sites-enabled /var/www/localhost/htdocs

	use coverpage || rm -rf "${D}"/var/www/localhost/htdocs/{index.html,images}
	use admin || rm -rf "${D}"/usr/sbin/admin "${D}"/usr/share/cherokee/admin

}

pkg_postinst() {
	enewgroup cherokee
	enewuser cherokee -1 -1 /var/www/localhost cherokee

	if use admin ; then
		echo  ""
		elog "Just run 'cherokee-admin' and go to: http://localhost:9090"
		echo  ""
	else
		echo  ""
		elog "Try USE=admin if you want a easy way to configure cherokee."
		echo  ""
	fi
}

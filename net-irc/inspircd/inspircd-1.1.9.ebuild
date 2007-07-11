# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-1.1.9.ebuild,v 1.1 2007/07/11 18:20:32 hansmi Exp $

inherit eutils toolchain-funcs multilib # subversion

IUSE="openssl gnutls ipv6 kernel_linux"

DESCRIPTION="InspIRCd - The Modular C++ IRC Daemon"
HOMEPAGE="http://www.inspircd.org"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
RDEPEND="
	>=sys-devel/gcc-3.3.0
	>=dev-lang/perl-5.8
	openssl? ( >=dev-libs/openssl-0.9.7d )
	gnutls? ( >=net-libs/gnutls-1.3.0 )"
DEPEND="${RDEPEND}"
SRC_URI="mirror://sourceforge/${PN}/InspIRCd-${PV}.tar.bz2"
#ESVN_REPO_URI="http://svn.inspircd.org/repository/trunk/inspircd"
#ESVN_PROJECT="inspircd"

S="${WORKDIR}/inspircd"

pkg_setup() {
	enewgroup inspircd
	enewuser inspircd -1 -1 -1 inspircd
}

src_compile() {
	local myconf=""

	# Write a configuration file
	# we don't use econf.
	USE_SSL="$(use_enable openssl)"
	use gnutls && USE_SSL="$(use_enable gnutls)"
	USE_SOCKET_ENGINE="--enable-epoll"
	./configure $(use_enable ipv6) --enable-remote-ipv6 ${USE_SSL} \
	${USE_SOCKET_ENGINE} \
	--prefix="/usr/$(get_libdir)/inspircd" \
	--config-dir="/etc/inspircd" --bin-dir="/usr/bin" \
	--library-dir="/usr/$(get_libdir)/inspircd" \
	--module-dir="/usr/$(get_libdir)/inspircd/modules" \
	|| die "configure failed"

	emake || die "emake failed"
}

src_install() {
	# the inspircd buildsystem does not create these, it's configure script
	# does. so, we have to at this point to make sure they are there.
	dodir /usr/$(get_libdir)/inspircd
	dodir /usr/$(get_libdir)/inspircd/modules
	dodir /etc/inspircd
	dodir /var/log/inspircd
	dodir /usr/include/inspircd

	emake install \
		LIBPATH="${D}/usr/$(get_libdir)/inspircd/" \
		MODPATH="${D}/usr/$(get_libdir)/inspircd/modules/" \
		CONPATH="${D}/etc/inspircd" \
		BINPATH="${D}/usr/bin" \
		BASE="${D}/usr/$(get_libdir)/inspircd/inspircd.launcher"

	insinto /usr/include/inspircd/
	doins "${S}"/include/*

	newinitd "${FILESDIR}"/init.d_inspircd inspircd
}

pkg_postinst() {
	chown -R inspircd:inspircd "${ROOT}"/etc/inspircd
	chmod 700 "${ROOT}"/etc/inspircd

	chmod 750 "${ROOT}"/var/log/inspircd
	chown -R inspircd:inspircd "${ROOT}"/var/log/inspircd

	chown -R inspircd:inspircd "${ROOT}"/usr/$(get_libdir)/inspircd
	chmod -R 755 "${ROOT}"/usr/$(get_libdir)/inspircd

	chmod -R 755 "${ROOT}"/usr/bin/inspircd
}

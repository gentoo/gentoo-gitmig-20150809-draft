# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-irc/inspircd/inspircd-1.1.14.ebuild,v 1.1 2007/11/12 21:47:32 hansmi Exp $

inherit eutils multilib

DESCRIPTION="InspIRCd - The Modular C++ IRC Daemon"
HOMEPAGE="http://www.inspircd.org/"
SRC_URI="http://www.inspircd.org/downloads/InspIRCd-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="gnutls ipv6 openssl kernel_linux"

DEPEND="
	>=sys-devel/gcc-3.3.0
	>=dev-lang/perl-5.8
	openssl? ( >=dev-libs/openssl-0.9.7d )
	gnutls? ( >=net-libs/gnutls-1.3.0 )"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

pkg_setup() {
	ebegin "Creating inspircd user and group"
	enewgroup inspircd
	enewuser inspircd -1 -1 -1 inspircd
	eend ${?}
}

src_compile() {
	local myconf="
		--disable-interactive
		--enable-epoll"

	# ./configure doesn't know --disable-gnutls, -ipv6 and -openssl options,
	# so should be used only --enable-like.
	use gnutls  && myconf="${myconf} $(use_enable gnutls)"
	use ipv6    && myconf="${myconf} $(use_enable ipv6) --enable-remote-ipv6"
	use openssl && myconf="${myconf} $(use_enable openssl)"

	./configure \
		--prefix="/usr" \
		--binary-dir="/usr/bin" \
		--config-dir="/etc/${PN}" \
		--library-dir="/usr/$(get_libdir)/${PN}" \
		--module-dir="/usr/$(get_libdir)/${PN}/modules" \
		${myconf} || die "configure failed"

	emake || die "emake failed"
}

src_install() {
	# the inspircd buildsystem does not create these, it's configure script
	# does. so, we have to at this point to make sure they are there.
	dodir /etc/${PN}
	dodir /usr/include/${PN}
	dodir /usr/$(get_libdir)/${PN}
	dodir /usr/$(get_libdir)/${PN}/modules
	dodir /var/log/${PN}

	emake install \
		BASE="${D}"/usr/$(get_libdir)/${PN}/inspircd.launcher \
		BINPATH="${D}"/usr/bin \
		CONPATH="${D}"/etc/${PN} \
		LIBPATH="${D}"/usr/$(get_libdir)/${PN}/ \
		MODPATH="${D}"/usr/$(get_libdir)/${PN}/modules/ \

	insinto /usr/include/inspircd/
	doins "${S}"/include/*

	newinitd "${FILESDIR}"/init.d_inspircd inspircd
}

pkg_postinst() {
	chown -R inspircd:inspircd "${ROOT}"/etc/${PN}
	chmod 700 "${ROOT}"/etc/${PN}

	chown -R inspircd:inspircd "${ROOT}"/var/log/${PN}
	chmod 750 "${ROOT}"/var/log/${PN}

	chown -R inspircd:inspircd "${ROOT}"/usr/$(get_libdir)/${PN}
	chmod -R 755 "${ROOT}"/usr/$(get_libdir)/${PN}

	chmod -R 755 "${ROOT}"/usr/bin/inspircd
}

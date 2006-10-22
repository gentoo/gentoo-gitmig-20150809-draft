# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/gkrellm/gkrellm-2.2.9-r1.ebuild,v 1.2 2006/10/22 09:47:23 corsair Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Single process stack of various system monitors"
HOMEPAGE="http://www.gkrellm.net/"
SRC_URI="http://members.dslextreme.com/users/billw/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ppc64 ~sparc ~x86"
IUSE="gnutls nls ssl X"

RDEPEND="dev-libs/glib
	gnutls? ( net-libs/gnutls )
	nls? ( virtual/libintl )
	ssl? ( dev-libs/openssl )
	X? ( >=x11-libs/gtk+-2 )"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )"

pkg_setup() {
	enewgroup gkrellmd
	enewuser gkrellmd -1 -1 -1 gkrellmd
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${P}-build.patch
	epatch "${FILESDIR}"/${P}-gnutls.patch
	epatch "${FILESDIR}"/gkrellm-mbmon-amd64.patch

	sed -e 's:#user\tnobody:user\tgkrellmd:' \
		-e 's:#group\tproc:group\tgkrellmd:' \
		-i server/gkrellmd.conf || die "sed gkrellmd.conf failed"

	sed -e "s:/usr/lib:/usr/$(get_libdir):" \
		-e "s:/usr/local/lib:/usr/local/$(get_libdir):" \
		-i src/${PN}.h || die "sed ${PN}.h failed"
}

src_compile() {
	if use X ; then
		emake \
			CC=$(tc-getCC) \
			INSTALLROOT=/usr \
			INCLUDEDIR=/usr/include/gkrellm2 \
			$(use nls || echo enable_nls=0) \
			$(use gnutls || echo without_gnutls=yes) \
			$(use ssl || echo without_ssl=yes) \
			|| die "emake failed"
	else
		cd server
		emake || die "emake failed"
	fi
}

src_install() {
	if use X ; then
		make install \
			$(use nls || echo enable_nls=0) \
			INSTALLDIR="${D}"/usr/bin \
			INCLUDEDIR="${D}"/usr/include \
			LOCALEDIR="${D}"/usr/share/locale \
			PKGCONFIGDIR="${D}"/usr/$(get_libdir)/pkgconfig \
			|| die "make install failed"

		mv "${D}"/usr/bin/{${PN},gkrellm2}

		dohtml *.html
		newman ${PN}.1 gkrellm2.1

		newicon src/icon.xpm ${PN}.xpm
		make_desktop_entry gkrellm2 GKrellM ${PN}.xpm
	else
		dobin server/gkrellmd || die "dobin failed"

		insinto /usr/include/gkrellm2
		doins server/gkrellmd.h
	fi

	doinitd "${FILESDIR}"/gkrellmd || die "doinitd failed"

	insinto /etc
	doins server/gkrellmd.conf

	doman gkrellmd.1
	dodoc Changelog CREDITS README
}

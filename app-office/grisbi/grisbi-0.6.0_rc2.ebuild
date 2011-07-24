# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/grisbi/grisbi-0.6.0_rc2.ebuild,v 1.8 2011/07/24 11:03:24 armin76 Exp $

EAPI="2"

inherit eutils autotools

IUSE="nls ofx ssl"

MY_PV=${PV/_rc/rc}
DESCRIPTION="Grisbi is a personal accounting application for Linux"
HOMEPAGE="http://www.grisbi.org"
SRC_URI="mirror://sourceforge/grisbi/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"

S="${WORKDIR}/${PN}-${MY_PV}"

# minimum gtk 2.10 to have print support
RDEPEND="dev-libs/libxml2
	>=x11-libs/gtk+-2.10.0:2
	ssl? ( dev-libs/openssl )
	ofx? ( >=dev-libs/libofx-0.7.0 )"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.20"

src_prepare() {
	epatch "${FILESDIR}/0.6.0_rc2-properly-detect-gmodule.patch"

	# Apply location patchs
	ebegin "Applying Gentoo documentation location patch"
	for i in \
		$(find ./ -name 'Makefile.am') \
		$(find ./ -name 'grisbi-manuel.html')
			do
				sed -i "s;doc/grisbi/;doc/${PF}/;g" "${i}"
			done
	eend 0

	# Fix Icon value in desktop file
	sed -i "s/grisbi.png/grisbi/" share/grisbi.desktop || die

	AT_M4DIR="macros" eautoreconf
}

src_configure() {
	econf \
		--with-plugins \
		$(use_with ofx) \
		$(use_enable nls) || die
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc AUTHORS NEWS README
}

pkg_postinst() {
	elog "The first thing you should do is set up the browser command in"
	elog "preferences after you start up grisbi.  Otherwise you will not"
	elog "be able to see the help and manuals."
}

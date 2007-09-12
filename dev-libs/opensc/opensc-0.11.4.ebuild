# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.4.ebuild,v 1.1 2007/09/12 21:29:13 alonbl Exp $

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"
SRC_URI="http://www.opensc-project.org/files/opensc/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="pcsc-lite openct nsplugin"

RDEPEND="dev-libs/openssl
	sys-libs/zlib
	openct? ( >=dev-libs/openct-0.5.0 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )
	nsplugin? ( app-crypt/pinentry )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nsplugin? ( dev-libs/libassuan )"

src_compile() {
	econf \
		$(use_enable openct) \
		$(use_enable pcsc-lite) \
		$(use_enable nsplugin) \
		--with-plugin-dir=/usr/lib/mozilla/plugins \
		--with-pin-entry="/usr/bin/pinentry" \
		|| die

	emake || die
}

src_install() {
	emake install DESTDIR="${D}" || die

	dodoc NEWS README
	dohtml doc/*.{html,css}

	insinto /etc
	doins etc/opensc.conf
}

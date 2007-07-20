# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.11.2.ebuild,v 1.1 2007/07/20 11:38:00 alonbl Exp $

WANT_AUTOMAKE="1.9"

inherit eutils libtool autotools

DESCRIPTION="SmartCard library and applications"
HOMEPAGE="http://www.opensc-project.org/opensc/"
SRC_URI="http://www.opensc-project.org/files/opensc/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="pcsc-lite openct"

RDEPEND="dev-libs/openssl
	sys-libs/zlib
	openct? ( >=dev-libs/openct-0.5.0 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	# --without-plugin-dir generates a /no directory
	# disable assuan stuff it create text realocation.
	econf \
		--with-plugin-dir=/usr/lib/mozilla/plugins \
		$(use_enable openct) \
		$(use_enable pcsc-lite) \
		--with-libassuan-prefix="${T}" \
		|| die

	emake -j1 || die
}

src_install() {
	make install DESTDIR="${D}" || die

	dodoc NEWS README
	dohtml doc/*.{html,css}

	insinto /etc
	doins etc/opensc.conf
}


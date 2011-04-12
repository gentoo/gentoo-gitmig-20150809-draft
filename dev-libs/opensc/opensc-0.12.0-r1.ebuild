# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/opensc/opensc-0.12.0-r1.ebuild,v 1.1 2011/04/12 07:13:18 flameeyes Exp $

EAPI="4"

DESCRIPTION="Libraries and applications to access smartcards."
HOMEPAGE="http://www.opensc-project.org/opensc/"

SRC_URI="http://www.opensc-project.org/files/${PN}/${P}.tar.gz"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc +pcsc-lite openct readline ssl zlib"

# libtool is required at runtime for libltdl
RDEPEND="sys-devel/libtool
	zlib? ( sys-libs/zlib )
	readline? ( sys-libs/readline )
	ssl? ( dev-libs/openssl )
	openct? ( >=dev-libs/openct-0.5.0 )
	pcsc-lite? ( >=sys-apps/pcsc-lite-1.3.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	app-text/docbook-xsl-stylesheets
	dev-libs/libxslt"

REQUIRED_USE="^^ ( pcsc-lite openct )"

src_configure() {
	econf \
		--docdir="/usr/share/doc/${PF}" \
		--htmldir="/usr/share/doc/${PF}/html" \
		$(use_enable doc) \
		$(use_enable openct) \
		$(use_enable pcsc-lite pcsc) \
		$(use_enable readline) \
		$(use_enable ssl openssl) \
		$(use_enable zlib)
}

src_install() {
	emake DESTDIR="${D}" install || die

	dodoc ChangeLog
}

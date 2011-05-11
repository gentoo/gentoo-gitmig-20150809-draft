# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/augeas/augeas-0.8.1.ebuild,v 1.1 2011/05/11 14:41:14 matsuu Exp $

EAPI="3"

DESCRIPTION="A library for changing configuration files"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"
IUSE="static-libs test"

RDEPEND="sys-libs/readline"
DEPEND="${RDEPEND}
	>=app-doc/NaturalDocs-1.40
	test? ( dev-lang/ruby )"

src_prepare() {
	if [ -f /usr/share/NaturalDocs/Config/Languages.txt ] ; then
		addwrite /usr/share/NaturalDocs/Config/Languages.txt
	fi
	if [ -f /usr/share/NaturalDocs/Config/Topics.txt ] ; then
		addwrite /usr/share/NaturalDocs/Config/Topics.txt
	fi
}

src_configure() {
	econf $(use_enable static-libs static) || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	use static-libs || find "${ED}" -name '*.la' -exec rm {} +

	dodoc AUTHORS ChangeLog README NEWS || die
}

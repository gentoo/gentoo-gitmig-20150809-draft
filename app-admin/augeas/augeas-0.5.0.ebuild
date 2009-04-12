# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/augeas/augeas-0.5.0.ebuild,v 1.2 2009/04/12 12:50:24 bluebird Exp $

DESCRIPTION="A library for changing configuration files"
HOMEPAGE="http://augeas.net/"
SRC_URI="http://augeas.net/download/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="doc test"

RDEPEND="sys-libs/readline"
DEPEND="${RDEPEND}
	doc? ( >=app-doc/NaturalDocs-1.40 )
	test? ( dev-lang/ruby )"

src_compile() {
	if [ -f /usr/share/NaturalDocs/Config/Languages.txt ] ; then
		addwrite /usr/share/NaturalDocs/Config/Languages.txt
	fi
	if [ -f /usr/share/NaturalDocs/Config/Topics.txt ] ; then
		addwrite /usr/share/NaturalDocs/Config/Topics.txt
	fi

	econf || die
	emake || die
}

src_install() {
	emake DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS ChangeLog README NEWS
}

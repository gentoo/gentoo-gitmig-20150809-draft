# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/fantasdic/fantasdic-1.0_beta7.ebuild,v 1.1 2009/05/19 14:39:02 matsuu Exp $

inherit eutils ruby

MY_P="${P/_/-}"
DESCRIPTION="Fantasdic is a client for the DICT protocol"
HOMEPAGE="http://www.gnome.org/projects/fantasdic/"
SRC_URI="http://www.mblondel.org/files/fantasdic/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gnome nls"

S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-lang/ruby-1.8"
RDEPEND="${DEPEND}
	>=dev-ruby/ruby-libglade2-0.14.1
	gnome? (
		>=dev-ruby/ruby-gnome2-0.14.1
		>=dev-ruby/ruby-gconf2-0.14.1
	)
	nls? ( >=dev-ruby/ruby-gettext-0.6.1 )"

src_install() {
	${RUBY} setup.rb install --prefix="${D}" || die

	domenu fantasdic.desktop

	erubydoc
}

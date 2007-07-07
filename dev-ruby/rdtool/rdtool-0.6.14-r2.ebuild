# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ruby/rdtool/rdtool-0.6.14-r2.ebuild,v 1.1 2007/07/07 20:54:42 graaff Exp $

inherit elisp-common ruby

DESCRIPTION="A multipurpose documentation format for Ruby"
HOMEPAGE="http://raa.ruby-lang.org/list.rhtml?name=rdtool"
SRC_URI="http://www2.pos.to/~tosh/ruby/rdtool/archive/${P}.tar.gz"
LICENSE="Ruby GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="emacs"

USE_RUBY="ruby18"

DEPEND=">=dev-lang/ruby-1.8.0
	dev-ruby/amstd
	emacs? ( virtual/emacs )"
SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	sed -i -e 's:^BIN_DIR = :&$(DESTDIR):' \
		   -e 's:^SITE_RUBY = :&$(DESTDIR):' rdtoolconf.rb \
		|| die "sed failed"
	mv rdtoolconf.rb extconf.rb
}

src_install() {
	dodir /usr/bin
	ruby_src_install

	if use emacs ; then
		elisp-install ${PN} utils/rd-mode.el
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

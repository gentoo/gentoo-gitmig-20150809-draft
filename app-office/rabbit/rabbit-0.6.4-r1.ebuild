# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/rabbit/rabbit-0.6.4-r1.ebuild,v 1.2 2011/03/12 11:50:03 graaff Exp $

EAPI=2
USE_RUBY="ruby18"

inherit ruby-ng elisp-common eutils

DESCRIPTION="An application to do presentation with RD document"
HOMEPAGE="http://www.cozmixng.org/~rwiki/?cmd=view;name=Rabbit"
SRC_URI="http://www.cozmixng.org/~kou/download/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls gs migemo tgif enscript emacs"

CDEPEND="emacs? ( virtual/emacs )"
DEPEND="${DEPEND} ${CDEPEND}"
RDEPEND="${RDEPEND} ${CDEPEND}
	nls? ( dev-ruby/ruby-gettext )
	gs? ( app-text/ghostscript-gpl )
	migemo? ( app-text/migemo )
	enscript? ( app-text/enscript )
	tgif? ( media-gfx/tgif )"

ruby_add_rdepend "
	dev-ruby/ruby-gnome2
	>=dev-ruby/ruby-gdkpixbuf2-0.15.0
	dev-ruby/rdtool"

each_ruby_configure() {
	${RUBY} setup.rb config --prefix=/usr || die
	${RUBY} setup.rb setup || die
}

all_ruby_compile() {
	if use emacs; then
		cd "${S}/misc/emacs"
		elisp-compile rabbit-mode.el
	fi
}

each_ruby_test() {
	${RUBY} test/run-test.rb || die "Tests failed."
}

each_ruby_install() {
	${RUBY} setup.rb install --prefix="${D}"
}

all_ruby_install() {
	dodoc NEWS.en NEWS.ja README.en README.ja TODO || die

	if use emacs; then
		cd "${S}/misc/emacs"
		elisp-install rabbit-mode rabbit-mode.el{,c}
		elisp-site-file-install "${FILESDIR}/50rabbit-mode-gentoo.el"
	fi

	insinto /usr/share/doc/${PF}
	doins -r sample
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

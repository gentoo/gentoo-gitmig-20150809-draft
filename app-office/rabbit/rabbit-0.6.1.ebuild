# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/rabbit/rabbit-0.6.1.ebuild,v 1.2 2009/12/17 10:55:25 ssuominen Exp $

inherit ruby elisp-common eutils

DESCRIPTION="An application to do presentation with RD document"
HOMEPAGE="http://www.cozmixng.org/~rwiki/?cmd=view;name=Rabbit"
SRC_URI="http://www.cozmixng.org/~kou/download/${P}.tar.gz"

LICENSE="Ruby"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls gs gnome-print migemo tgif enscript emacs"

DEPEND="virtual/ruby
	emacs? ( virtual/emacs )"
RDEPEND="${DEPEND}
	dev-ruby/ruby-gnome2
	>=dev-ruby/ruby-gdkpixbuf2-0.15.0
	dev-ruby/rdtool
	nls? ( dev-ruby/ruby-gettext )
	gs? ( virtual/ghostscript )
	gnome-print? ( gnome-base/libgnomeprint )
	migemo? ( app-text/migemo )
	enscript? ( app-text/enscript )
	tgif? ( media-gfx/tgif )"

src_compile() {
	ruby_src_compile

	if use emacs; then
		cd "${S}/misc/emacs"
		elisp-compile rabbit-mode.el
	fi
}

src_test() {
	test/run-test.rb
}

src_install() {
	${RUBY} setup.rb install --prefix="${D}"
	erubydoc

	if use emacs; then
		cd "${S}/misc/emacs"
		elisp-install rabbit-mode rabbit-mode.el{,c}
		elisp-site-file-install "${FILESDIR}/50rabbit-mode-gentoo.el"
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
}

pkg_postrm() {
	use emacs && elisp-site-regen
}

# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-mail/notmuch/notmuch-0.9-r2.ebuild,v 1.1 2011/11/04 14:49:13 aidecoe Exp $

EAPI=4

PYTHON_DEPEND="python? 2:2.5"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="2.4 3.*"
RUBY="/usr/bin/ruby18"
RDOC="/usr/bin/rdoc18"

inherit elisp-common distutils
inherit autotools-utils

DESCRIPTION="The mail indexer"
HOMEPAGE="http://notmuchmail.org/"
SRC_URI="${HOMEPAGE}/releases/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
REQUIRED_USE="test? ( crypt emacs )"
IUSE="bash-completion crypt debug doc emacs python ruby test vim zsh-completion"

CDEPEND="
	>=dev-libs/glib-2.14
	dev-libs/gmime:2.4
	dev-libs/xapian
	doc? ( python? ( dev-python/sphinx ) )
	sys-libs/talloc
	debug? ( dev-util/valgrind )
	emacs? ( >=virtual/emacs-23 )
	ruby? ( dev-lang/ruby:1.8 )
	x86? ( >=dev-libs/xapian-1.2.7-r2 )
	vim? ( || ( >=app-editors/vim-7.0 >=app-editors/gvim-7.0 ) )
	"
DEPEND="${CDEPEND}
	dev-util/pkgconfig
	test? ( sys-devel/gdb )
	"
RDEPEND="${CDEPEND}
	crypt? ( app-crypt/gnupg )
	zsh-completion? ( app-shells/zsh )
	"

DOCS=( AUTHORS NEWS README TODO )
PATCHES=(
	"${FILESDIR}/${PV}-fix-lib-makefile-local.patch"
	"${FILESDIR}/${PV}-emacsetcdir.patch"
	)
SITEFILE="50${PN}-gentoo.el"

bindings() {
	if use $1; then
		pushd bindings/$1 || die
		shift
		$@
		popd || die
	fi
}

pkg_setup() {
	if use emacs; then
		elisp-need-emacs 23 || die "Emacs version too low"
	fi
	use python && python_pkg_setup
}

src_prepare() {
	echo "S=${S}"
	autotools-utils_src_prepare
	bindings python distutils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--bashcompletiondir="${ROOT}/usr/share/bash-completion"
		--emacslispdir="${ROOT}/${SITELISP}/${PN}"
		--emacsetcdir="${ROOT}/${SITEETC}/${PN}"
		--zshcompletiondir="${ROOT}/usr/share/zsh/site-functions"
		$(use_with bash-completion)
		$(use_with emacs)
		$(use_with zsh-completion)
	)
	autotools-utils_src_configure

	r_conf() {
		${RUBY} extconf.rb || die
	}
	bindings ruby r_conf
}

src_compile() {
	autotools-utils_src_compile
	bindings python distutils_src_compile
	bindings ruby emake

	if use doc; then
		pydocs() {
			pushd docs || die
			emake html
			mv html ../python || die
			popd || die
		}

		rdocs() {
			${RDOC} --main 'Notmuch' --title 'Notmuch Ruby API' --op ruby *.c
		}

		bindings python pydocs
		bindings ruby rdocs
	fi
}

src_install() {
	autotools-utils_src_install

	if use emacs; then
		elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	fi

	if use vim; then
		insinto /usr/share/vim/vimfiles
		doins -r vim/plugin vim/syntax
	fi

	DOCS="" bindings python distutils_src_install
	bindings ruby emake DESTDIR="'${D}'" install

	if use doc; then
		bindings python dohtml -r python
		bindings ruby dohtml -r ruby
	fi
}

pkg_postinst() {
	use emacs && elisp-site-regen
	use python && distutils_pkg_postinst

	if use python; then
		echo
		einfo "Python API documentation is also online available at:"
		einfo "  http://packages.python.org/notmuch/"
	fi
}

pkg_postrm() {
	use emacs && elisp-site-regen
	use python && distutils_pkg_postrm
}

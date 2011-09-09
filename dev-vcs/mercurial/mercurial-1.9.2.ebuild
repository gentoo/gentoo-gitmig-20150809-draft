# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-vcs/mercurial/mercurial-1.9.2.ebuild,v 1.2 2011/09/09 16:50:10 mgorny Exp $

EAPI=3
PYTHON_DEPEND="2"
PYTHON_USE_WITH="threads"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit bash-completion-r1 elisp-common eutils distutils

DESCRIPTION="Scalable distributed SCM"
HOMEPAGE="http://mercurial.selenic.com/"
SRC_URI="http://mercurial.selenic.com/release/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x64-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="bugzilla emacs gpg test tk zsh-completion"

RDEPEND="bugzilla? ( dev-python/mysql-python )
	gpg? ( app-crypt/gnupg )
	tk? ( dev-lang/tk )
	zsh-completion? ( app-shells/zsh )"
DEPEND="emacs? ( virtual/emacs )
	test? ( app-arch/unzip
		dev-python/pygments )"

PYTHON_CFLAGS=(
	"2.* + -fno-strict-aliasing"
	"* - -ftracer -ftree-vectorize"
)

PYTHON_MODNAME="${PN} hgext"
SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	distutils_src_prepare

	# fix up logic that won't work in Gentoo Prefix (also won't outside in
	# certain cases), bug #362891
	sed -i -e 's:xcodebuild:nocodebuild:' setup.py || die
}

src_compile() {
	distutils_src_compile

	if use emacs; then
		cd "${S}"/contrib
		elisp-compile mercurial.el || die "elisp-compile failed!"
	fi

	rm -rf contrib/{win32,macosx}
}

src_install() {
	distutils_src_install

	newbashcomp contrib/bash_completion ${PN} || die

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		newins contrib/zsh_completion _hg
	fi

	rm -f doc/*.?.txt
	dodoc CONTRIBUTORS PKG-INFO README doc/*.txt
	cp hgweb*.cgi "${ED}"/usr/share/doc/${PF}/

	dobin hgeditor
	dobin contrib/hgk
	dobin contrib/hg-ssh

	rm -f contrib/hgk contrib/hg-ssh

	rm -f contrib/bash_completion
	cp -r contrib "${ED}"/usr/share/doc/${PF}/
	doman doc/*.?

	cat > "${T}/80mercurial" <<-EOF
HG="${EPREFIX}/usr/bin/hg"
EOF
	doenvd "${T}/80mercurial"

	if use emacs; then
		elisp-install ${PN} contrib/mercurial.el* || die "elisp-install failed!"
		elisp-site-file-install "${FILESDIR}"/${SITEFILE}
	fi
}

src_test() {
	cd "${S}/tests/"
	rm -rf *svn*				# Subversion tests fail with 1.5
	rm -f test-archive			# Fails due to verbose tar output changes
	rm -f test-convert-baz*		# GNU Arch baz
	rm -f test-convert-cvs*		# CVS
	rm -f test-convert-darcs*	# Darcs
	rm -f test-convert-git*		# git
	rm -f test-convert-mtn*		# monotone
	rm -f test-convert-tla*		# GNU Arch tla
	rm -f test-doctest*			# doctest always fails with python 2.5.x
	if [[ ${EUID} -eq 0 ]]; then
		einfo "Removing tests which require user privileges to succeed"
		rm -f test-command-template	# Test is broken when run as root
		rm -f test-convert			# Test is broken when run as root
		rm -f test-lock-badness		# Test is broken when run as root
		rm -f test-permissions		# Test is broken when run as root
		rm -f test-pull-permission	# Test is broken when run as root
		rm -f test-clone-failure
		rm -f test-journal-exists
		rm -f test-repair-strip
	fi

	testing() {
		local testdir="${T}/tests-${PYTHON_ABI}"
		rm -rf "${testdir}"
		"$(PYTHON)" run-tests.py --tmpdir="${testdir}"
	}
	python_execute_function testing
}

pkg_postinst() {
	distutils_pkg_postinst
	use emacs && elisp-site-regen

	elog "If you want to convert repositories from other tools using convert"
	elog "extension please install correct tool:"
	elog "  dev-vcs/cvs"
	elog "  dev-vcs/darcs"
	elog "  dev-vcs/git"
	elog "  dev-vcs/monotone"
	elog "  dev-vcs/subversion"
}

pkg_postrm() {
	distutils_pkg_postrm
	use emacs && elisp-site-regen
}
